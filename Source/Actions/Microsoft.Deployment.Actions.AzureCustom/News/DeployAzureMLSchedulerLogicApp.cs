using System.ComponentModel.Composition;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure;
using Microsoft.Azure.Management.Resources;
using Microsoft.Azure.Management.Resources.Models;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.ErrorCode;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.Newws
{
    [Export(typeof(IAction))]
    public class DeployAzureMLSchedulerLogicApp : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            var azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            var subscription = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            var resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            var location = request.DataStore.GetJson("SelectedLocation")["Name"].ToString();

            var deploymentName = request.DataStore.GetValue("DeploymentName");
            var storageAccountName = request.DataStore.GetValue("StorageAccountName");
            var logicAppName = request.DataStore.GetValue("LogicAppName");

            //var apiKey = request.DataStore.GetAllValues("Exp1", "TopicApiKey");
            //var apiUrl = request.DataStore.GetAllValues("ApiUrl");

            //dataStore.AddToDataStore("Exp1", "TopicApiKey", "VB4mYM5WD0EzEFvJ8z8sIpei4Y85oiIdGAT5z/G/+YVfWSu8ISvECZ8KalKji6a6AEkxoFDpNrhsrMUq0mkJjA==");
            //dataStore.AddToDataStore("Exp2", "ImagesApiKey", "TM1oZ3taPmRiR0V6wxEkDYAQaRip9JxJ+HQhyo/9T9VcwSpbobye+jNPDyMayN+y8u+PQVFv1gbH1sIhft0uqQ==");
            //dataStore.AddToDataStore("Exp3", "EntityApiKey", "VYDEekiPGZDSFTnjgURi8ik+hIHh4AwJTT7RvdH9FUL0MsS/NpAgtRyUkQROuHG+FTIGohhoLYfwWxhjZgBJSg==");

            //dataStore.AddToDataStore("Exp1", "TopicApiUrl", "https://ussouthcentral.services.azureml.net/workspaces/0a5545bf61b948c5b04684eadae10e09/services/2b67d0d308e646b2b8a0f9d7d934b5c7/execute?api-version=2.0&details=true");
            //dataStore.AddToDataStore("Exp2", "ImagesApiUrl", "https://ussouthcentral.services.azureml.net/workspaces/0a5545bf61b948c5b04684eadae10e09/services/f321bb3ab3624173a7c0de239957e6dd/execute?api-version=2.0&details=true");
            //dataStore.AddToDataStore("Exp3", "EntityApiUrl", "https://ussouthcentral.services.azureml.net/workspaces/0a5545bf61b948c5b04684eadae10e09/services/02e09e59cddd4cbe8027a5b93974ad0a/execute?api-version=2.0&details=true");



            //var apiKeyTopics = apiKey[0];
            //var apiKeyEntities = apiKey[1];
            //var apiKeyImages = apiKey[2];

            //var apiUrlTopics = apiUrl[0];
            //var apiUrlEntities = apiUrl[1];
            //var apiUrlImages = apiUrl[2];



            var param = new AzureArmParameterGenerator();
            param.AddStringParam("resourcegroup", resourceGroup);
            param.AddStringParam("subscription", subscription);
            param.AddStringParam("storageaccountname", storageAccountName);
            param.AddStringParam("logicappname", logicAppName);
            param.AddStringParam("apikeytopics", apiKeyTopics);
            param.AddStringParam("apikeyimages", apiKeyImages);
            param.AddStringParam("apikeyentities", apiKeyEntities);
            param.AddStringParam("apiurltopics", apiUrlTopics);
            param.AddStringParam("apiurlentities", apiUrlEntities);
            param.AddStringParam("apiurlimages", apiUrlImages);

            var armTemplate = JsonUtility.GetJObjectFromJsonString(System.IO.File.ReadAllText(Path.Combine(request.Info.App.AppFilePath, "Service/AzureArm/AzureMLSchedulerLogicApp.json")));
            var armParamTemplate = JsonUtility.GetJObjectFromObject(param.GetDynamicObject());
            armTemplate.Remove("parameters");
            armTemplate.Add("parameters", armParamTemplate["parameters"]);

            SubscriptionCloudCredentials creds = new TokenCloudCredentials(subscription, azureToken);
            Microsoft.Azure.Management.Resources.ResourceManagementClient client = new ResourceManagementClient(creds);


            var deployment = new Microsoft.Azure.Management.Resources.Models.Deployment()
            {
                Properties = new DeploymentPropertiesExtended()
                {
                    Template = armTemplate.ToString(),
                    Parameters = JsonUtility.GetEmptyJObject().ToString()
                }
            };

            var validate = await client.Deployments.ValidateAsync(resourceGroup, deploymentName, deployment, new CancellationToken());
            if (!validate.IsValid)
            {
                return new ActionResponse(ActionStatus.Failure, JsonUtility.GetJObjectFromObject(validate), null,
                     DefaultErrorCodes.DefaultErrorCode, $"Azure:{validate.Error.Message} Details:{validate.Error.Details}");
            }

            var deploymentItem = await client.Deployments.CreateOrUpdateAsync(resourceGroup, deploymentName, deployment, new CancellationToken());
            return new ActionResponse(ActionStatus.Success, deploymentItem);
        }
    }
}
