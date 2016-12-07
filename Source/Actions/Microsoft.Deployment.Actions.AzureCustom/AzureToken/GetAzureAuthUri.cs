using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.Text;
using System.Threading.Tasks;

using Microsoft.Deployment.Common;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;
using Microsoft.Azure;
using Microsoft.Azure.Management.Resources;
using Microsoft.Azure.Management.Resources.Models;

namespace Microsoft.Deployment.Actions.AzureCustom.AzureToken
{
    [Export(typeof(IAction))]
    public class GetAzureAuthUri : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            var aadTenant = request.DataStore.GetValue("AADTenant");

            string authBase;
            string clientId;
            string resource;

            string oauthType = (request.DataStore.GetValue("oauthType") ?? string.Empty).ToLowerInvariant();
            switch (oauthType)
            {
                case "mscrm":
                    authBase = Constants.MsCrmAuthority;
                    clientId = Constants.MsCrmClientId;
                    resource = Constants.MsCrmResource;
                    break;
                case "keyvault":
                    string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
                    string subscriptionId = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();

                    // Make sure the Key Vault is registered
                    SubscriptionCloudCredentials creds = new TokenCloudCredentials(subscriptionId, azureToken);

                    using (ResourceManagementClient managementClient = new ResourceManagementClient(creds))
                    {
                        ProviderListResult providersResult = managementClient.Providers.List(null);

                        bool kvExists = false;
                        foreach (var p in providersResult.Providers)
                        {
                            if (p.Namespace.EqualsIgnoreCase("Microsoft.KeyVault"))
                            {
                                kvExists = p.RegistrationState.EqualsIgnoreCase("Registered");
                                break;
                            }
                        }

                        if (!kvExists)
                        {
                            ProviderRegistionResult result = await managementClient.Providers.RegisterAsync("Microsoft.KeyVault");
                            if (result.StatusCode != System.Net.HttpStatusCode.OK)
                            {
                                return new ActionResponse(ActionStatus.Failure, JsonUtility.GetEmptyJObject(), "MsCrm_ErrorRegisterKv");
                            }
                        }
                    }

                    authBase = string.Format(Constants.AzureAuthUri, aadTenant);
                    clientId = Constants.MicrosoftClientIdCrm;
                    resource = Constants.AzureManagementApi;

                    break;
                default:
                    authBase = string.Format(Constants.AzureAuthUri, aadTenant);
                    clientId = Constants.MicrosoftClientId;
                    resource = Constants.AzureManagementApi;
                    break;
            }

            Dictionary<string, string> message = new Dictionary<string, string>
            {
                { "client_id", clientId },
                { "prompt", "consent" },
                { "response_type", "code" },
                { "redirect_uri", Uri.EscapeDataString(request.Info.WebsiteRootUrl + Constants.WebsiteRedirectPath) },
                { "resource", Uri.EscapeDataString(resource) }
            };

            StringBuilder builder = new StringBuilder();
            builder.Append(authBase);
            foreach (KeyValuePair<string, string> keyValuePair in message)
            {
                builder.Append(keyValuePair.Key + "=" + keyValuePair.Value);
                builder.Append("&");
            }

            return new ActionResponse(ActionStatus.Success, JsonUtility.GetJObjectFromStringValue(builder.ToString()));
        }
    }
}