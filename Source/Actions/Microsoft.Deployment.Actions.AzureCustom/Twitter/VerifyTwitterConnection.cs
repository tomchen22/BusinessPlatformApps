﻿using System.ComponentModel.Composition;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.ErrorCode;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.Twitter
{
    [Export(typeof(IAction))]
    public class VerifyTwitterConnection : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            var azureToken = request.DataStore.GetJson("AzureToken", "access_token");
            var subscription = request.DataStore.GetJson("SelectedSubscription", "SubscriptionId");
            var resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            var location = request.DataStore.GetJson("SelectedLocation", "Name");

            HttpResponseMessage connection = await
                new AzureHttpClient(azureToken, subscription, resourceGroup).ExecuteWithSubscriptionAndResourceGroupAsync(HttpMethod.Get,
                    "/providers/Microsoft.Web/connections/twitter", "2015-08-01-preview", string.Empty);

            if (!connection.IsSuccessStatusCode)
            {
                return new ActionResponse(ActionStatus.FailureExpected,
                    JsonUtility.GetJObjectFromJsonString(connection.Content.ReadAsStringAsync().Result),null,DefaultErrorCodes.DefaultErrorCode,
                    "Failed to get consent");
            }

            var connectionData = JsonUtility.GetJObjectFromJsonString(await connection.Content.ReadAsStringAsync());
            if (connectionData["properties"]["statuses"][0]["status"].ToString() != "Connected")
            {
                return new ActionResponse(ActionStatus.FailureExpected, connectionData);
            }

            return new ActionResponse(ActionStatus.Success, connectionData);
        }
    }
}

