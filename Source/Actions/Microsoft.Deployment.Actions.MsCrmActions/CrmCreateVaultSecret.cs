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
    using System.Threading.Tasks;
    using System.IdentityModel.Tokens.Jwt;
    using Microsoft.Azure.ActiveDirectory.GraphClient;

    [Export(typeof(IAction))]
    public class CrmCreateVaultSecret : BaseAction
    {
        private const string _crmServicePrincipal = "b861dbcc-a7ef-4219-a005-0e4de4ea7dcf"; // DO NOT CHANGE THIS
        private async Task<string> GetCrmConnectorObjectID(string graphToken, string tenantId)
        {
            Uri servicePointUri = new Uri("https://graph.windows.net");
            Uri serviceRoot = new Uri(servicePointUri, tenantId);
            ActiveDirectoryClient adClient = new ActiveDirectoryClient(serviceRoot, async () => { return graphToken; });
            var princs = await adClient.ServicePrincipals.ExecuteAsync().ConfigureAwait(false);
            

            for (;;)
            {
                var currentPage = princs.CurrentPage;

                foreach (var p in currentPage)
                {
                    if (p.AppId.EqualsIgnoreCase(_crmServicePrincipal))
                        return p.ObjectId;
                }

                if (!princs.MorePagesAvailable)
                    break;

                princs = await princs.GetNextPageAsync().ConfigureAwait(false);
            } 

            // NO NO NO! Null p should not happen!
            return null;
        }

        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string azureToken = request.DataStore.GetJson("AzureToken")["access_token"].ToString();
            string kvToken = request.DataStore.GetJson("kvToken")["access_token"].ToString();
            string graphToken = request.DataStore.GetJson("graphToken")["access_token"].ToString();
            string crmToken = request.DataStore.GetValue("MsCrmToken");


            // Get user's object ID and tenant ID (in the Azure subscription where the vault is created)
            string oid = null;
            string tenantId = null;
            int propCount = 0;
            foreach (var c in new JwtSecurityToken(azureToken).Claims)
            {
                switch (c.Type.ToLowerInvariant())
                {
                    case "oid":
                        oid = c.Value;
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


            // Get user's tenant ID in the CRM implicit subscription
            string crmtenantId = null;
            foreach (var c in new JwtSecurityToken(crmToken).Claims)
            {
                if (c.Type.EqualsIgnoreCase("tid"))
                {
                        crmtenantId = c.Value;
                        break;
                }
            }

            string subscriptionID = request.DataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString();
            string resourceGroup = request.DataStore.GetValue("SelectedResourceGroup");
            string vaultName = request.DataStore.GetValue("VaultName") ?? "bpstv-" + RandomGenerator.GetRandomLowerCaseCharacters(12) ;
            string secretName = request.DataStore.GetValue("SecretName") ?? "bpst-mscrm-secret";
            string connectionString = request.DataStore.GetAllValues("SqlConnectionString")[0];
            string organizationId = request.DataStore.GetValue("OrganizationId");

            string secretId = string.Empty;

            try
            {
                SubscriptionCloudCredentials credentials = new TokenCloudCredentials(subscriptionID, azureToken);
                TokenCredentials credentialsKv = new TokenCredentials(azureToken);

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
                            client.Vaults.Delete(resourceGroup, vaultName);
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
                                AccessPolicies = new List<AccessPolicyEntry>()
                            };

                            // Access policy for the owner
                            AccessPolicyEntry apeOwner = new AccessPolicyEntry();
                            apeOwner.Permissions = new Permissions(new[] { "get", "create", "delete", "list", "update", "import", "backup", "restore" }, new[] { "all" }, new[] { "all" });
                            apeOwner.TenantId = new Guid(tenantId);
                            apeOwner.ObjectId = new Guid(oid);
                            p.AccessPolicies.Add(apeOwner);

                            vaultParams = new VaultCreateOrUpdateParameters()
                            {
                                Location = resourceClient.ResourceGroups.Get(resourceGroup).ResourceGroup.Location,
                                Properties = p
                            };

                            vault = client.Vaults.CreateOrUpdate(resourceGroup, vaultName, vaultParams);
                            System.Threading.Thread.Sleep(3000);
                            vault.Validate();
                        }
                    }


                    // Access policy for the CRM exporter
                    AccessPolicyEntry ape = new AccessPolicyEntry();
                    ape.Permissions = new Permissions(null, new[] { "get" });
                    ape.TenantId = new Guid(tenantId);
                    // ape.ApplicationId = new Guid(_crmServicePrincipal);
                    ape.ObjectId = new Guid("a1685f9d-abab-4c93-957c-32ffd34cba2b"); // CRM object id {a1685f9d-abab-4c93-957c-32ffd34cba2b}
                    ape.ObjectId = new Guid(GetCrmConnectorObjectID(graphToken, tenantId).Result);
                    vault.Properties.AccessPolicies.Add(ape);

                    // Update permissions
                    vaultParams = new VaultCreateOrUpdateParameters(vault.Location, vault.Properties);
                    vault = client.Vaults.CreateOrUpdate(resourceGroup, vaultName, vaultParams);
                    vault.Validate();
                    System.Threading.Thread.Sleep(3000);


                    // Create the secret
                    KeyVaultClient kvClient = new KeyVaultClient( new TokenCredentials(kvToken));
                    SecretBundle secret = await kvClient.SetSecretAsync(vault.Properties.VaultUri,
                                                                        secretName,
                                                                        connectionString,
                                                                        new Dictionary<string, string>() { { organizationId, crmtenantId } },
                                                                        null /* Do I need to set a content type? */,
                                                                        new SecretAttributes() { Enabled = true });

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