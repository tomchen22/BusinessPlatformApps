using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class CogntiveServiceTests
    {
        [TestMethod]
        public async Task DeployCognitiveServiceTextTest()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);
            var responseBody = JObject.FromObject(result.Body);
            var subscriptionId = responseBody["value"][0]["SubscriptionId"].ToString();

            dataStore.AddToDataStore("SubscriptionId", subscriptionId, DataStoreType.Private);
            dataStore.AddToDataStore("SelectedResourceGroup", "testing");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService");
            dataStore.AddToDataStore("SkuName", "F0");

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
