using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.Dynamic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AnalysisServices.Tabular;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.CognitiveServices
{
    [Export(typeof(IAction))]
    public class RegisterCognitiveServices : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string subscription = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            request.DataStore.AddToDataStore("register", "azureProvider", "Microsoft-CognitivieServices");

            if ((await RequestUtility.CallAction(request, "Microsoft-RegisterProvider")).IsSuccess)
            {
                return new ActionResponse(ActionStatus.Success);
            }

            return new ActionResponse(ActionStatus.Failure);
        }
    }
}
