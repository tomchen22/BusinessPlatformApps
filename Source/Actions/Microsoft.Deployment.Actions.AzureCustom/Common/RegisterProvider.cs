using System.ComponentModel.Composition;
using System.Threading.Tasks;

using Microsoft.Azure;
using Microsoft.Azure.Management.Resources;
using Microsoft.Azure.Management.Resources.Models;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.Common
{
    [Export(typeof(IAction))]
    public class RegisterProvider : BaseAction
    {
        private static string REGISTERED = "Registered";

        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string azureProvider = request.DataStore.GetLastValue("AzureProvider");
            string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string subscriptionId = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();

            SubscriptionCloudCredentials creds = new TokenCloudCredentials(subscriptionId, azureToken);

            using (ResourceManagementClient managementClient = new ResourceManagementClient(creds))
            {
                bool isRegistered = false;
                ProviderListResult providers = managementClient.Providers.List(null);

                foreach (var provider in providers.Providers)
                {
                    if (provider.Namespace.EqualsIgnoreCase(azureProvider))
                    {
                        isRegistered = provider.RegistrationState.EqualsIgnoreCase(REGISTERED);
                        break;
                    }
                }

                if (!isRegistered)
                {
                    AzureOperationResponse operationResponse = managementClient.Providers.Register(azureProvider);
                    if (operationResponse.StatusCode != System.Net.HttpStatusCode.OK || operationResponse.StatusCode != System.Net.HttpStatusCode.Accepted)
                        return new ActionResponse(ActionStatus.Failure, JsonUtility.GetEmptyJObject(), "RegisterProviderError");
                }
            }

            return new ActionResponse(ActionStatus.Success, JsonUtility.GetEmptyJObject());
        }
    }
}