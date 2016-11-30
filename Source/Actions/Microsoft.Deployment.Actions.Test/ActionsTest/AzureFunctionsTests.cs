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
    public class AzureFunctionsTests
    {
        [TestMethod]
        public async Task DeployAzureFunction()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);
            var responseBody = JObject.FromObject(result.Body);
            var subscriptionId = responseBody["value"][0];

            dataStore.AddToDataStore("SelectedSubscription", subscriptionId, DataStoreType.Private);
            dataStore.AddToDataStore("SelectedResourceGroup", "testing");

            var locationResult = await TestHarness.ExecuteActionAsync("Microsoft-GetLocations", dataStore);
            Assert.IsTrue(locationResult.IsSuccess);
            var location = locationResult.Body.GetJObject()["value"][5];
            dataStore.AddToDataStore("SelectedLocation", location, DataStoreType.Public);

            dataStore.AddToDataStore("DeploymentName", "FunctionDeploymentTest");
            dataStore.AddToDataStore("FunctionAppHostingPlan", "FunctionPlanName");
            dataStore.AddToDataStore("SiteName", "UnitTest" + RandomGenerator.GetRandomLowerCaseCharacters(5));

            var response = TestHarness.ExecuteAction("Microsoft-CreateResourceGroup", dataStore);

            response = TestHarness.ExecuteAction("Microsoft-DeployAzureFunction", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);

        }

        [TestMethod]
        public async Task DeployAzureFunctionAssets()
        {
            var dataStore = await AAD.GetTokenWithDataStore();
            var result = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", dataStore);
            Assert.IsTrue(result.IsSuccess);
            var responseBody = JObject.FromObject(result.Body);
            var subscriptionId = responseBody["value"][0];

            dataStore.AddToDataStore("SelectedSubscription", subscriptionId, DataStoreType.Private);
            dataStore.AddToDataStore("SelectedResourceGroup", "testing");

            var locationResult = await TestHarness.ExecuteActionAsync("Microsoft-GetLocations", dataStore);
            Assert.IsTrue(locationResult.IsSuccess);
            var location = locationResult.Body.GetJObject()["value"][5];
            dataStore.AddToDataStore("SelectedLocation", location, DataStoreType.Public);

            dataStore.AddToDataStore("DeploymentName", "FunctionDeploymentTest");
            dataStore.AddToDataStore("FunctionAppHostingPlan", "FunctionPlanName");
            dataStore.AddToDataStore("SiteName", "UnitTestfcrow");

            dataStore.AddToDataStore("FunctionName", "TestA");
            dataStore.AddToDataStore("FunctionFileName", "TweetFunctionCSharp.cs" );


            var response = TestHarness.ExecuteAction("Microsoft-CreateResourceGroup", dataStore);

            response = TestHarness.ExecuteAction("Microsoft-DeployAzureFunctionAssets", dataStore);
            Assert.IsTrue(response.Status == ActionStatus.Success);

        }

    }
}

