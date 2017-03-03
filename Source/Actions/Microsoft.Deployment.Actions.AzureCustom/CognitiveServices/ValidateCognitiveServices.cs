using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.Dynamic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AnalysisServices.Tabular;
using Microsoft.Azure;
using Microsoft.Azure.Management.Resources;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.CognitiveServices
{
    [Export(typeof(IAction))]
    public class ValidateCognitiveServices : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string subscription = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            var location = request.DataStore.GetValue("CognitiveLocation");
            string permissionsToCheck =  request.DataStore.GetValue("CognitiveServices");
   
            List<string> cognitiveServicesToCheck = permissionsToCheck.Split(',').Select(p=> p.Trim()).ToList();
            AzureHttpClient client = new AzureHttpClient(azureToken, subscription, resourceGroup);

            SubscriptionCloudCredentials creds = new TokenCloudCredentials(subscription, azureToken);
            Microsoft.Azure.Management.Resources.ResourceManagementClient registrationClient = new ResourceManagementClient(creds);
            await registrationClient.Providers.UnregisterAsync("Microsoft.CognitiveServices");
            var registration = await registrationClient.Providers.RegisterAsync("Microsoft.CognitiveServices");

            while(true)
            {
                Thread.Sleep(new TimeSpan(0, 0, 1));
            }

            bool passPermissionCheck = true;
            // Check if permissions are fine
            var getPermissionsResponse = await client.ExecuteWithSubscriptionAsync(HttpMethod.Get,
                $"providers/Microsoft.CognitiveServices/locations/{location}/settings/accounts", "2016-02-01-preview",
                string.Empty);

            var getPermissionsBody = JsonUtility.GetJsonObjectFromJsonString(await getPermissionsResponse.Content.ReadAsStringAsync());

            foreach (var permission in getPermissionsBody["settings"])
            {
                if(cognitiveServicesToCheck.Contains(permission["kind"].ToString()) && permission["allowCreate"].ToString().ToLowerInvariant() == "false")
                {
                    
                    passPermissionCheck = false;
                }

                if (cognitiveServicesToCheck.Contains(permission["kind"].ToString()))
                {
                    cognitiveServicesToCheck.Remove(permission["kind"].ToString());
                }
            }

           

            if (passPermissionCheck && cognitiveServicesToCheck.Count == 0)
            {
                return new ActionResponse(ActionStatus.Success);
            }


            // IF not then check if user can enable
            var getOwnerResponse = await client.ExecuteWithSubscriptionAsync(HttpMethod.Post,
                $"providers/Microsoft.CognitiveServices/locations/{location}/checkAccountOwner", "2016-02-01-preview",
                JsonUtility.GetEmptyJObject().ToString());

            var getOwnerBody = JsonUtility.GetJsonObjectFromJsonString(await getOwnerResponse.Content.ReadAsStringAsync());

            if (getOwnerBody["isAccountOwner"].ToString().ToLowerInvariant() == "false")
            {
                return new ActionResponse(ActionStatus.Failure, getOwnerBody, null, null, $"Your account admin ({getOwnerBody["accountOwnerEmail"].ToString()}) needs to enable cognitive services for this subscription, the following cognitive services should be enabled in order to proceed- {permissionsToCheck}");
            }

            // User does not have permission but we can enable permission for the user as they are the admin
            dynamic obj = new ExpandoObject();
            obj.resourceType = "accounts";
            obj.settings = new ExpandoObject[cognitiveServicesToCheck.Count];
            for (int i = 0; i < cognitiveServicesToCheck.Count; i++)
            {
                obj.settings[i] = new ExpandoObject();
                obj.settings[i].kind = cognitiveServicesToCheck[i];
                obj.settings[i].allowCreate = true;
            }

            var setPermissionsResponse = await client.ExecuteWithSubscriptionAsync(HttpMethod.Post,
                $"providers/Microsoft.CognitiveServices/locations/{location}/updateSettings", "2016-02-01-preview",
               JsonUtility.GetJObjectFromObject(obj).ToString());
            if (!setPermissionsResponse.IsSuccessStatusCode)
            {
                return new ActionResponse(ActionStatus.Failure, await setPermissionsResponse.Content.ReadAsStringAsync(), null, null, $"Unable to assign permissions for the cogntivie services {permissionsToCheck}. Use the Azure Portal to enable these services");
            }




            return new ActionResponse(ActionStatus.Success);
        }
    }
}
