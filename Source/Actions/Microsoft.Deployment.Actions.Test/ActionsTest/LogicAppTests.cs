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

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class LogicAppTests
    {
        [TestMethod]
        public async Task CreateConnectionToLogicApp()
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

            var response = TestHarness.ExecuteAction("Microsoft-CreateResourceGroup", dataStore);

            string[] connectors = new string[5] {"bingnews", "azureml", "azureblob", "sql", "cognitiveservicetextanalytics"};


            foreach (string connector in connectors)
            {
                dataStore.AddToDataStore("ConnectorName", connector);
                response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
                Assert.IsTrue(response.Status == ActionStatus.Success);
            }
        }
    }
}
