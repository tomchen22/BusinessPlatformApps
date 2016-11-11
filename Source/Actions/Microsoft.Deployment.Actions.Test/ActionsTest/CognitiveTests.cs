using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class CognitiveTests
    {

        [TestMethod]
        public async Task DeployCognitiveServiceTextTest()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);

            var subscriptionId = result.Body.GetJObject()["value"][0];
            dataStore.AddToDataStore("SelectedSubscription", subscriptionId, DataStoreType.Public);

            var locationResult = await TestHarness.ExecuteActionAsync("Microsoft-GetLocations", dataStore);
            Assert.IsTrue(locationResult.IsSuccess);
            var location = locationResult.Body.GetJObject()["value"][5];
            dataStore.AddToDataStore("SelectedLocation", location, DataStoreType.Public);

            dataStore.AddToDataStore("SelectedResourceGroup", "testing");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService");
            dataStore.AddToDataStore("CognitiveSkuName", "F0");
            dataStore.AddToDataStore("DeploymentName", "TestCognitiveService");

            var response = TestHarness.ExecuteAction("Microsoft-CreateResourceGroup", dataStore);
            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveServiceText", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);

            if (response.Status == ActionStatus.Success)
            {
                response = TestHarness.ExecuteAction("Microsoft-DeleteResourceGroup", dataStore);
                Assert.IsTrue(response.Status == ActionStatus.Success);
            }
        }
    }
}
