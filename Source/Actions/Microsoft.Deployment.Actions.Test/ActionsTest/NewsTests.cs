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
using Microsoft.Deployment.Common.ActionModel;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class NewsTests
    {
        public static string randomString = RandomGenerator.GetRandomLowerCaseCharacters(5);

        [TestMethod]
        public async Task NewsTemplateDeployment()
        {
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();

            // Deploy SQL Scripts
            dataStore.AddToDataStore("SqlConnectionString", TestHarness.GetSqlPagePayload("NewsTemplateTest"));
            dataStore.AddToDataStore("SqlServerIndex", "0");
            dataStore.AddToDataStore("SqlScriptsFolder", "Service/Database");

            var response = await TestHarness.ExecuteActionAsync("Microsoft-DeploySQLScripts", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.Status == ActionStatus.Success);

            // Deploy Function
            dataStore.AddToDataStore("DeploymentName", "FunctionDeploymentTest");
            dataStore.AddToDataStore("FunctionName", "unittestfunction" + TestHarness.RandomCharacters);
            dataStore.AddToDataStore("RepoUrl", "https://github.com/juluczni/AzureFunctionsNewsTemplate");

            response = TestHarness.ExecuteAction("Microsoft-DeployAzureFunction", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //HARDCODED
            //dataStore.AddToDataStore("FunctionName", "hardcodedfunction3");


            // FTP File Function
            //response = TestHarness.ExecuteAction("Microsoft-DeployPrivateAssemblyToFunction", dataStore, "Microsoft-NewsTemplateTest");
            //Assert.IsTrue(response.IsSuccess);

            // Deploy AML Stuff Deploy AML Web Service
            // Set up storage account first

            dataStore.AddToDataStore("StorageAccountName", "unittesttrialbpst" + TestHarness.RandomCharacters);
            dataStore.AddToDataStore("StorageAccountType", "Standard_LRS");
            dataStore.AddToDataStore("StorageAccountEncryptionEnabled", "false");
            response = TestHarness.ExecuteAction("Microsoft-CreateAzureStorageAccount", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);


            // Deploy experiments
            dataStore.AddToDataStore("PlanName", "motestplan");
            dataStore.AddToDataStore("Replace", "WebServiceFile", "Service/AzureML/Experiments/TopicImagesWebService.json");
            dataStore.AddToDataStore("Replace", "WebServiceName", "TopicImageswsdeployed");
            dataStore.AddToDataStore("CommitmentPlan", "motestcomm");

            response = await TestHarness.ExecuteActionAsync("Microsoft-DeployAzureMLWebServiceFromFile", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.Status == ActionStatus.Success);

            //response = await TestHarness.ExecuteActionAsync("Microsoft-DeployAzureMLWebService", dataStore, "Microsoft-NewsTemplateTest");
            //Assert.IsTrue(response.Status == ActionStatus.Success);

            //response = await TestHarness.ExecuteActionAsync("Microsoft-WaitForAzureMLWebServiceCreation", dataStore, "Microsoft-NewsTemplateTest");
            //Assert.IsTrue(response.Status == ActionStatus.Success);

            //Azure Storage Deployment

            //Create Storage account
            dataStore.AddToDataStore("DeploymentName", "StorageDeploymentTest");
            dataStore.AddToDataStore("StorageAccountName", "unitteststorage" + TestHarness.RandomCharacters);
            dataStore.AddToDataStore("StorageAccountType", "Standard_LRS");
            dataStore.AddToDataStore("StorageAccountEncryptionEnabled", "false");

            response = await TestHarness.ExecuteActionAsync("Microsoft-CreateAzureStorageAccount", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.IsSuccess);
            response = await TestHarness.ExecuteActionAsync("Microsoft-WaitForArmDeploymentStatus", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.IsSuccess);

            //Get key
            response = await TestHarness.ExecuteActionAsync("Microsoft-GetStorageAccountKey", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.IsSuccess);
            response = await TestHarness.ExecuteActionAsync("Microsoft-WaitForArmDeploymentStatus", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.IsSuccess);

            //Deploy blob
            dataStore.AddToDataStore("StorageAccountContainer", "mycontainer" + TestHarness.RandomCharacters);

            response = await TestHarness.ExecuteActionAsync("Microsoft-DeployStorageAccountContainer", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.IsSuccess);

            //Cognitive Service & Connector Deployment

            //Deploy Text Analytics Service
            dataStore.AddToDataStore("DeploymentName", "CongitiveServiceDeployText");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService");
            dataStore.AddToDataStore("CognitiveServiceType", "TextAnalytics");
            dataStore.AddToDataStore("CognitiveSkuName", "S1");

            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveService", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Get Key for Text Analytics
            response = TestHarness.ExecuteAction("Microsoft-GetCognitiveKey", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Create connector for Text Analytics
            dataStore.AddToDataStore("ConnectorName", "cognitiveservicestextanalytics");

            dynamic payload = new ExpandoObject();
            payload.apiKey = dataStore.GetDataStoreItem("CognitiveServiceKey");
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);
            dataStore.AddToDataStore("ConnectorDisplayName", "TextAnalytics");
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            
            dataStore.AddToDataStore("KeyNumber", "1");

            //Deploy Bing Cognitive Service
            dataStore.AddToDataStore("DeploymentName", "CongitiveServiceDeployBing");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService2");
            dataStore.AddToDataStore("CognitiveServiceType", "Bing.Search");
            dataStore.AddToDataStore("CognitiveSkuName", "S1");
            dataStore.AddToDataStore("CognitiveServiceKey", "");

            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveService", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Get Key for Bing
            response = TestHarness.ExecuteAction("Microsoft-GetCognitiveKey", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Create connector for Bing News
            dataStore.AddToDataStore("ConnectorName", "bingnews");

            payload = new ExpandoObject();
            payload.apiKey = dataStore.GetDataStoreItem("CognitiveServiceKey");
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);
            dataStore.AddToDataStore("ConnectorDisplayName", "BingNews");
            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Image Cache Logic App

            dataStore.AddToDataStore("DeploymentName", "LogicAppDeploymentTest");
            dataStore.AddToDataStore("LogicAppName", "testname");
            dataStore.AddToDataStore("SearchQuery", "microsoft");
            dataStore.AddToDataStore("ConnectorName", "azureblob");
            dataStore.AddToDataStore("ConnectorDisplayName", "azureblob");
            dataStore.AddToDataStore("ImageCacheLogicApp", "testname");

            payload = new ExpandoObject();
            payload.accountName = "cacheimages";
            payload.accessKey = dataStore.GetDataStoreItem("StorageAccountKey");
            payload = JsonUtility.GetJObjectFromObject(payload);
            dataStore.AddToDataStore("ConnectorPayload", payload);

            response = TestHarness.ExecuteAction("Microsoft-CreateConnectorToLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-UpdateBlobStorageConnector", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-DeployImageCachingLogicApp", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //News Template Logic App



            dataStore.AddToDataStore("Replace", "WebServiceFile", "Service/AzureML/Experiments/EntityWebService.json");
            dataStore.AddToDataStore("Replace", "WebServiceName", "entitywsdeployed1");
            response = await TestHarness.ExecuteActionAsync("Microsoft-DeployAzureMLWebServiceFromFile", dataStore, "Microsoft-NewsTemplateTest");
            Assert.IsTrue(response.Status == ActionStatus.Success);
        }


        [TestMethod]
        public async Task NewsTemplateE2E()
        {

            //Manual steps - deploy function + deploy cognitive services
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();

            //Deploy Azure Function - need to fix DLL issue before the test will work

            dataStore.AddToDataStore("DeploymentName", "FunctionDeploymentTest");
            dataStore.AddToDataStore("FunctionAppHostingPlan", "FunctionPlanName");
            dataStore.AddToDataStore("Name", "unituestrialbpst" + randomString);

            var response = TestHarness.ExecuteAction("Microsoft-DeployAzureFunction", dataStore);
            Assert.IsTrue(response.IsSuccess);
            response = TestHarness.ExecuteAction("Microsoft-WaitForArmDeploymentStatus", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Deploy Azure storage account

            //Create Storage account
            dataStore.AddToDataStore("DeploymentName", "StorageDeploymentTest");
            dataStore.AddToDataStore("StorageAccountName", "unittesttrialbpst" + randomString);
            dataStore.AddToDataStore("StorageAccountType", "Standard_LRS");
            dataStore.AddToDataStore("StorageAccountEncryptionEnabled", "false");

            response = TestHarness.ExecuteAction("Microsoft-CreateAzureStorageAccount", dataStore);
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
            dataStore.AddToDataStore("DeploymentName", "CongitiveServiceDeployText");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService");
            dataStore.AddToDataStore("CognitiveServiceType", "TextAnalytics");
            dataStore.AddToDataStore("CognitiveSkuName", "S1");

            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveService", dataStore);
            Assert.IsTrue(response.IsSuccess);

            dataStore.AddToDataStore("DeploymentName", "CongitiveServiceDeployBing");
            dataStore.AddToDataStore("CognitiveServiceName", "TestCognitiveService2");
            dataStore.AddToDataStore("CognitiveServiceType", "Bing.Search");
            dataStore.AddToDataStore("CognitiveSkuName", "S1");

            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveService", dataStore);
            Assert.IsTrue(response.IsSuccess);

            response = TestHarness.ExecuteAction("Microsoft-GetCognitiveKey", dataStore);
            Assert.IsTrue(response.IsSuccess);

            response = TestHarness.ExecuteAction("Microsoft-DeployCognitiveService", dataStore);
            Assert.IsTrue(response.IsSuccess);

            response = TestHarness.ExecuteAction("Microsoft-GetCognitiveKey", dataStore);
            Assert.IsTrue(response.IsSuccess);

            //Image Cache Logic App
            dataStore.AddToDataStore("DeploymentName", "LogicAppDeploymentTest");
            dataStore.AddToDataStore("LogicAppName", "testname");
            dataStore.AddToDataStore("SearchQuery", "microsoft");
            dataStore.AddToDataStore("ConnectorName", "azureblob");
            dataStore.AddToDataStore("ConnectorDisplayName", "azureblob");
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
            dataStore.AddToDataStore("SiteName", "unituestrialbpst" + randomString);
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
            payload.database = "newstemplate";
            payload.password = "Billing.26";
            payload.server = "testtemplateworks.database.windows.net";
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

