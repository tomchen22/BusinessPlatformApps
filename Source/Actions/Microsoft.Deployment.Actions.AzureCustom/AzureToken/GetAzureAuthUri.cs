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
using System.IdentityModel.Tokens.Jwt;

namespace Microsoft.Deployment.Actions.AzureCustom.AzureToken
{
    [Export(typeof(IAction))]
    public class GetAzureAuthUri : BaseAction
    {
        private void ExtractUserandTenant(string token, out string oId, out string tenantId)
        {
            int propCount = 0;
            oId = tenantId = null;

            foreach (var c in new JwtSecurityToken(token).Claims)
            {
                switch (c.Type.ToLowerInvariant())
                {
                    case "oid":
                        oId = c.Value;
                        propCount++;
                        break;
                    case "tid":
                        tenantId = c.Value;
                        propCount++;
                        break;
                }

                if (propCount >= 2)
                    break;
            }
        }

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
                    authBase = string.Format(Constants.AzureAuthUri, aadTenant);
                    clientId = Constants.MsCrmClientId;
                    resource = Constants.AzureManagementApi;
                    break;
                case "keyvault":
                    string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
                    string subscriptionId = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
                    string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");


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

                        AzureOperationResponse operationResponse;
                        if (!kvExists)
                        {
                            operationResponse = await managementClient.Providers.RegisterAsync("Microsoft.KeyVault");
                            if (operationResponse.StatusCode != System.Net.HttpStatusCode.OK)
                                return new ActionResponse(ActionStatus.Failure, JsonUtility.GetEmptyJObject(), "MsCrm_ErrorRegisterKv");

                            System.Threading.Thread.Sleep(3000);
                        }
                        
                        string oid ;
                        string tenantID;
                        ExtractUserandTenant(azureToken, out oid, out tenantID);

                        const string vaultApiVersion = "2015-06-01";
                        string tempVaultName = "bpst-" + RandomGenerator.GetRandomLowerCaseCharacters(12);
                        GenericResource genRes = new GenericResource("westus")
                        {
                            Properties = "{\"sku\": { \"family\": \"A\", \"name\": \"Standard\" }, \"tenantId\": \"" + tenantID + "\", \"accessPolicies\": [], \"enabledForDeployment\": true }"
                        };

                        operationResponse = await managementClient.Resources.CreateOrUpdateAsync(resourceGroup, new ResourceIdentity(tempVaultName, "Microsoft.KeyVault/vaults", vaultApiVersion), genRes);
                        bool operationSucceeded = (operationResponse.StatusCode == System.Net.HttpStatusCode.OK);
                        System.Threading.Thread.Sleep(3000);

                        if (operationSucceeded)
                        {
                            ResourceIdentity resIdent = new ResourceIdentity(tempVaultName, "Microsoft.KeyVault/vaults", vaultApiVersion);
                            operationResponse = await managementClient.Resources.DeleteAsync(resourceGroup, resIdent);
                            operationSucceeded = (operationResponse.StatusCode == System.Net.HttpStatusCode.OK);
                        }

                        if (!operationSucceeded)
                            return new ActionResponse(ActionStatus.Failure, JsonUtility.GetEmptyJObject(), "MsCrm_ErrorRegisterKv");
                    }

                    clientId = Constants.MicrosoftClientIdCrm;
                    resource = Constants.AzureKeyVaultApi;
                    authBase = string.Format(Constants.AzureAuthUri, aadTenant);

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