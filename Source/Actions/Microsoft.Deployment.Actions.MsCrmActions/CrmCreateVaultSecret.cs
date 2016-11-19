namespace Microsoft.Deployment.Common.Actions.MsCrm
{
    using Azure.KeyVault.Models;
    using Azure.Management.KeyVault.Models;
    using Azure.Management.Resources;
    using Microsoft.Azure;
    using Microsoft.Azure.KeyVault;
    using Microsoft.Azure.Management.KeyVault;
    using Microsoft.Deployment.Common.ActionModel;
    using Microsoft.Deployment.Common.Actions;
    using Microsoft.Deployment.Common.Helpers;
    using Rest;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.Composition;
    using System.Net.Http;
    using System.Net.Http.Headers;
    using System.Threading;
    using System.Threading.Tasks;


    [Export(typeof(IAction))]
    public class CrmCreateVaultSecret : BaseAction
    {
        private string _azureToken = "NO_TOKEN";
        private readonly Guid _crmServicePrincipal = new Guid("b861dbcc-a7ef-4219-a005-0e4de4ea7dcf"); // DO NOT CHANGE THIS

        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string _azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string subscriptionID = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            string vaultName = request.DataStore.GetValue("VaultName") ?? "bpst-mscrm-vault";
            string secretName = request.DataStore.GetValue("SecretName") ?? "bpst-mscrm-secret";
            string connectionString = request.DataStore.GetAllValues("SqlConnectionString")[0];
            string organizationId = request.DataStore.GetValue("OrganizationId");
            string tenantId = request.DataStore.GetValue("TenantId") ?? "72f988bf-86f1-41af-91ab-2d7cd011db47";

            string secretId = string.Empty;

            try
            {
                SubscriptionCloudCredentials credentials = new TokenCloudCredentials(subscriptionID, _azureToken);
                TokenCredentials credentialsKv = new TokenCredentials(_azureToken);

                using (KeyVaultManagementClient client = new KeyVaultManagementClient(credentialsKv))
                {
                    client.SubscriptionId = subscriptionID;

                    // Check if a vault already exists
                    Vault vault = null;
                    var vaults = client.Vaults.ListByResourceGroup(resourceGroup);

                    foreach (var v in client.Vaults.ListByResourceGroup(resourceGroup))
                    {
                        if (v.Name.EqualsIgnoreCase(vaultName))
                        {
                            vault = v;
                            break;
                        }
                    }

                    VaultCreateOrUpdateParameters vaultParams = null;
                    // Create the vault
                    if (vault == null)
                    {
                        using (ResourceManagementClient resourceClient = new ResourceManagementClient(credentials))
                        {
                            // Set properties
                            VaultProperties p = new VaultProperties()
                            {
                                Sku = new Sku(SkuName.Standard),
                                TenantId = new Guid(tenantId),
                                AccessPolicies = new AccessPolicyEntry[] { }
                            };

                            vaultParams = new VaultCreateOrUpdateParameters()
                            {
                                Location = resourceClient.ResourceGroups.Get(resourceGroup).ResourceGroup.Location,
                                Properties = p
                            };

                            vault = client.Vaults.CreateOrUpdate(resourceGroup, vaultName, vaultParams);
                        }
                    }


                    AccessPolicyEntry ape = new AccessPolicyEntry
                    {
                        Permissions = new Permissions(null, new[] { "get" }),
                        //PermissionsToSecrets = new[] { "get" },
                        ApplicationId = _crmServicePrincipal,
                        TenantId = vault.Properties.TenantId,
//                        ObjectId = new Guid("a1685f9d-abab-4c93-957c-32ffd34cba2b")
                    };

                    
                    // Set who has permission to read this
                    vault.Properties.AccessPolicies.Add(ape);
                    vaultParams = new VaultCreateOrUpdateParameters(vault.Location, vault.Properties);
                    vault = client.Vaults.CreateOrUpdate(resourceGroup, vaultName, vaultParams);

                    // Create the secret
                    KeyVaultClient kvClient = new KeyVaultClient(credentialsKv);
                    
                    SecretBundle secret = await kvClient.SetSecretAsync(vault.Properties.VaultUri, secretName, connectionString, new Dictionary<string, string>() { { organizationId, tenantId } },
                                                 null, new SecretAttributes() { Enabled = true });

                    request.DataStore.AddToDataStore("KeyVault", secret.Id, DataStoreType.Private);
                    secretId = secret.Id;
                }
            }
            catch (Exception)
            {
                throw;
            }

            return new ActionResponse(ActionStatus.Success, secretId, true);
        }
    }
}