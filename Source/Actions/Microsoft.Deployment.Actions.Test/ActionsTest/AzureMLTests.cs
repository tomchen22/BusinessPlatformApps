using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AzureML;
using AzureML.Contract;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class AzureMLTests
    {
        [TestMethod]
        public async Task DeployAzureMLWorkspaceTest()
        {
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();
            dataStore.AddToDataStore("WorkspaceName", "testazuremlworkspace" + RandomGenerator.GetRandomLowerCaseCharacters(3));
            dataStore.AddToDataStore("StorageAccountName", "testazuremlstorage" + RandomGenerator.GetRandomLowerCaseCharacters(5));
            dataStore.AddToDataStore("DeploymentName", "MLWorkspaceDeployment");
            dataStore.AddToDataStore("PlanName", "testazuremlplan");
            dataStore.AddToDataStore("SkuName", "S1");
            dataStore.AddToDataStore("SkuTier", "Standard");
            dataStore.AddToDataStore("SkuCapacity", "1");

            var response = TestHarness.ExecuteAction("Microsoft-DeployAzureMLWorkspace", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);
        }

        [TestMethod]
        public async Task GetExperimentsTest()
        {
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();
            ManagementSDK sdk = new ManagementSDK();
            var workspaces = sdk.GetWorkspacesFromRdfe(dataStore.GetJson("AzureToken")["access_token"].ToString(),
                dataStore.GetJson("SelectedSubscription")["SubscriptionId"].ToString());

            var workspaceSettings = new WorkspaceSetting()
            {
                AuthorizationToken = workspaces[0].AuthorizationToken.PrimaryToken,
                Location = workspaces[0].Region,
                WorkspaceId = workspaces[0].Id
            };
            var experiments = sdk.GetExperiments(workspaceSettings);
            string rawJson = string.Empty;
            Experiment exp = sdk.GetExperimentById(workspaceSettings, experiments[0].ExperimentId, out rawJson);
        }
    }
}