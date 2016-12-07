using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.ActionModel;
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
    public class CogntiveServiceTests
    {
        [Ignore]
        [TestMethod]
        public async Task DeployCognitiveServiceTextTest()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);
            var responseBody = JObject.FromObject(result.Body);
            var subscriptionId = responseBody["value"][0]["SubscriptionId"].ToString();

            dynamic obj = new ExpandoObject();
            obj.SelectedSubscription = new ExpandoObject();
            obj.SelectedSubscription.SubscriptionId = subscriptionId;

            dynamic loc = new ExpandoObject();
            loc.SelectedLocation = new ExpandoObject();
            loc.SelectedLocation.Name = "westus";

            dataStore.AddObjectDataStore(JsonUtility.GetJObjectFromObject(obj), DataStoreType.Any);
            dataStore.AddObjectDataStore(JsonUtility.GetJObjectFromObject(loc), DataStoreType.Any);

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
