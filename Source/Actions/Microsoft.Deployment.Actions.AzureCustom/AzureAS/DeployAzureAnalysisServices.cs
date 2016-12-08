using System.ComponentModel.Composition;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Azure;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.AzureAS
{
    [Export(typeof(IAction))]
    public class DeployAzureAnalysisServices : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string subscription = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");

            string serverNane = request.DataStore.GetValue("ASServerName") ?? "analysisserver-" + RandomGenerator.GetRandomLowerCaseCharacters(5);
            string location = request.DataStore.GetValue("ASlocation") ?? "westcentralus";
            string sku = request.DataStore.GetValue("ASsku") ?? "D1";
            string admin = request.DataStore.GetValue("ASadmin") ?? "admin@admin.com";


            SubscriptionCloudCredentials creds = new TokenCloudCredentials(subscription, azureToken);
            AzureArmParameterGenerator param = new AzureArmParameterGenerator();
            param.AddStringParam("name", serverNane );
            param.AddStringParam("location", location);
            param.AddStringParam("sku", sku);
            param.AddStringParam("admin", admin);

            string armTemplatefilePath = File.ReadAllText(request.ControllerModel.SiteCommonFilePath + "/service/arm/NewAzureAS.json");
            string template = AzureUtility.GetAzureArmParameters(armTemplatefilePath, param);
            await AzureUtility.ValidateAndDeployArm(creds, resourceGroup, "ASDeployment", template);
            return await AzureUtility.WaitForArmDeployment(creds, resourceGroup, "ASDeployment");
        }
    }
}
