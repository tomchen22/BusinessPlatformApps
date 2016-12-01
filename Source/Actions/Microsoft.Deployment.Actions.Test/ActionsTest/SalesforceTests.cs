using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;

namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class SalesforceTests
    {
        public string sfUsername = Credential.Instance.Salesforce.Username;
        public string sfPassword = Credential.Instance.Salesforce.Password;
        public string sfToken = Credential.Instance.Salesforce.Token;
        public string sqlServer = Credential.Instance.Sql.Server;
        public string sqlUsername = Credential.Instance.Sql.Username;
        public string sqlDatabase = Credential.Instance.Sql.Database;
        public string sqlPassword = Credential.Instance.Sql.Password;

        [TestMethod]
        public void SalesforceSqlArtefactsDeploysSuccessful()
        {
            DataStore dataStore = TestHarness.GetCommonDataStoreWithSql().Result;
            dataStore.AddToDataStore("SalesforceUser", this.sfUsername, DataStoreType.Public);
            dataStore.AddToDataStore("SalesforcePassword", this.sfPassword, DataStoreType.Private);
            dataStore.AddToDataStore("SalesforceToken", this.sfToken, DataStoreType.Private);
            dataStore.AddToDataStore("SalesforceUrl", "https://login.salesforce.com/", DataStoreType.Public);
            dataStore.AddToDataStore("ObjectTables", "Opportunity,Account,Lead,Product2,OpportunityLineItem,OpportunityStage,User,UserRole", DataStoreType.Public);

            this.CleanDb(dataStore);

            var response = TestHarness.ExecuteAction("Microsoft-SalesforceGetObjectMetadata", dataStore);

            dataStore.AddObjectDataStore("Objects", JsonUtility.GetJObjectFromObject(response.Body), DataStoreType.Any);

            response = TestHarness.ExecuteAction("Microsoft-SalesforceSqlArtefacts", dataStore);

            Assert.IsTrue(response.Status == ActionStatus.Success);
        }

        [TestMethod]
        public void RunSalesforceCredentialValidation()
        {
            DataStore dataStore = new DataStore();
            dataStore.AddToDataStore("SalesforceUser", this.sfUsername, DataStoreType.Public);
            dataStore.AddToDataStore("SalesforcePassword", this.sfPassword, DataStoreType.Private);
            dataStore.AddToDataStore("SalesforceToken", this.sfToken, DataStoreType.Private);
            dataStore.AddToDataStore("SalesforceUrl", "https://login.salesforce.com/", DataStoreType.Public);

            var result = TestHarness.ExecuteAction("Microsoft-ValidateSalesforceCredentials", dataStore);
            Assert.IsTrue(result.Status == ActionStatus.Success);
        }

        public void CleanDb(DataStore dataStore)
        {
            dataStore.AddToDataStore("SqlServerIndex", 0, DataStoreType.Any);
            dataStore.AddToDataStore("SqlScriptsFolder", "Service/Database/Cleanup", DataStoreType.Any);

            var response = TestHarness.ExecuteAction("Microsoft-DeploySQLScripts", dataStore);
            
            Assert.IsTrue(response.Status == ActionStatus.Success);
        }
    }
}