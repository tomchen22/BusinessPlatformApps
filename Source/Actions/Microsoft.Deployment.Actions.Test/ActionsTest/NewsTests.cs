using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Dynamic;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    class NewsTests
    {
        public static string randomString = RandomGenerator.GetRandomLowerCaseCharacters(5);
        [TestMethod]
        public async Task NewsTemplateE2E()
        {

            //Manual steps - deploy function + deploy cognitive services
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();

            //Deploy Azure Function



            //Deploy Azure storage account

            //Create Storage account
            dataStore.AddToDataStore("DeploymentName", "StorageDeploymentTest");
            dataStore.AddToDataStore("StorageAccountName", "unittesttrialbpst" + randomString);
            dataStore.AddToDataStore("StorageAccountType", "Standard_LRS");
            dataStore.AddToDataStore("StorageAccountEncryptionEnabled", "false");

            var response = TestHarness.ExecuteAction("Microsoft-CreateAzureStorageAccount", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Get key
            response = TestHarness.ExecuteAction("Microsoft-GetStorageAccountKey", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Deploy blob
            dataStore.AddToDataStore("StorageAccountContainer", "mycontainer" + randomString);

            response = TestHarness.ExecuteAction("Microsoft-DeployStorageAccountContainer", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Deploy cognitive services


            //Image Cache Logic App
            dataStore.AddToDataStore("DeploymentName", "LogicAppDeploymentTest");
            dataStore.AddToDataStore("LogicAppName", "testname");
            dataStore.AddToDataStore("SearchQuery", "microsoft");
            dataStore.AddToDataStore("ConnectorName", "azureblob");
            dataStore.AddToDataStore("ConnectorDisplayName", "azureblob");
            dataStore.AddToDataStore("SiteName", "unituestrialbpstxskjf");
            dataStore.AddToDataStore("ImageCacheLogicApp", "testname");

            dynamic payload = new ExpandoObject();
            payload.accountName = "cacheimages";
            payload.accessKey = "bsDCAU00sSqE48QIg+7cXKNhJbG7/0HnMzzl6nN0Y6L2pJoSTFvpHdKlpQPjjayKtks/IDeU2ep1ONPZh7UAKg==";
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);

            response = TestHarness.ExecuteAction("Microsoft-CreateAzureStorageAccount", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-DeployImageCachingLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //NewsTemplateLogicApp
            dataStore.AddToDataStore("ConnectorName", "bingnews");
            payload = new ExpandoObject();
            payload.apiKey = "a1a17649b8784afd9219fdcf3f945552";
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);
            dataStore.AddToDataStore("ConnectorDisplayName", "BingNews");
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            dataStore.AddToDataStore("ConnectorName", "cognitiveservicestextanalytics");
            payload = new ExpandoObject();
            payload.apiKey = "488546b19ba040179eaaf172f19196cf";
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);
            dataStore.AddToDataStore("ConnectorDisplayName", "TextAnalytics");
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            dataStore.AddToDataStore("ConnectorName", "sql");
            payload = new ExpandoObject();
            payload.authType = "windows";
            payload.database = "testruns";
            payload.password = "Billing.26";
            payload.server = "pbist.database.windows.net";
            payload.username = "pbiadmin";
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);
            dataStore.AddToDataStore("ConnectorDisplayName", "InsertIngestTimeStamp");
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            dataStore.AddToDataStore("LogicAppName", "testname2");
            response = TestHarness.ExecuteAction("Microsoft-DeployNewsTemplateLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
        }
    }
}

