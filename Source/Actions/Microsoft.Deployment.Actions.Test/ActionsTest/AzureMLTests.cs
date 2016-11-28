using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class AzureMLTests
    {
        [TestMethod]
        public async Task DeployAzureMLWorkspaceTest()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);
            var responseBody = JObject.FromObject(result.Body);
            var subscriptionId = responseBody.GetJObject()["value"][0];

            dataStore.AddToDataStore("SelectedResourceGroup", "UnitTest");
            dataStore.AddToDataStore("SelectedSubscription", subscriptionId);
            dataStore.AddToDataStore("WorkspaceName", "testazuremlworkspace");
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
    }
}