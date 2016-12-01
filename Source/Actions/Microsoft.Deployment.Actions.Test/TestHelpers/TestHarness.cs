using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.AppLoad;
using Microsoft.Deployment.Common.Controller;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.Enums;
using Microsoft.Deployment.Common.Helpers;
using Microsoft.Deployment.Common.Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Microsoft.Deployment.Actions.Test
{
    [TestClass]
    public class TestHarness
    {
        private static CommonController Controller { get; set; }
        public static string TemplateName = "TestApp";
        private static DataStore CommonDataStore = null;
        private static string CurrentDatabase = string.Empty;

        [AssemblyInitialize()]
        public static void AssemblyInit(TestContext context)
        {
            AppFactory factory = new AppFactory();
            CommonControllerModel model = new CommonControllerModel()
            {
                AppFactory = factory,
                AppRootFilePath = factory.AppPath,
                SiteCommonFilePath = factory.SiteCommonPath,
                ServiceRootFilePath = factory.SiteCommonPath + "../",
                Source = "TEST",
            };

            Controller = new CommonController(model);
            Credential.Load();
        }

        [AssemblyCleanup]
        public static void Cleanup()
        {
            RemoveTempDB();
        }

        public static ActionResponse ExecuteAction(string actionName, DataStore datastore)
        {
            UserInfo info = new UserInfo();
            info.ActionName = actionName;
            info.AppName = TemplateName;
            return Controller.ExecuteAction(info, new ActionRequest() { DataStore = datastore }).Result;
        }

        public static async Task<ActionResponse> ExecuteActionAsync(string actionName, DataStore datastore)
        {
            UserInfo info = new UserInfo();
            info.ActionName = actionName;
            info.AppName = TemplateName;
            return await Controller.ExecuteAction(info, new ActionRequest() { DataStore = datastore });
        }

        public static async Task<DataStore> GetCommonDataStore()
        {
            if (CommonDataStore == null)
            {
                await SetUp();
            }

            DataStore store =
                JsonConvert.DeserializeObject<DataStore>(JsonUtility.GetJsonStringFromObject(CommonDataStore));
            return store;
        }

        public static async Task<DataStore> GetCommonDataStoreWithSql()
        {
            var dataStore = await GetCommonDataStore();

            CreateTempDB();

            var connString = (GetSqlPagePayload(CurrentDatabase).Body as JObject)["value"].ToString();

            dataStore.AddToDataStore("SqlConnectionString", connString);

            return dataStore;
        }

        public static async Task<bool> SetUp()
        {
            CommonDataStore = await AAD.GetTokenWithDataStore();

            var subscriptionResult = await TestHarness.ExecuteActionAsync("Microsoft-GetAzureSubscriptions", CommonDataStore);
            Assert.IsTrue(subscriptionResult.IsSuccess);
            var subscriptionId = subscriptionResult.Body.GetJObject()["value"][0];
            CommonDataStore.AddToDataStore("SelectedSubscription", subscriptionId, DataStoreType.Public);

            var locationResult = await TestHarness.ExecuteActionAsync("Microsoft-GetLocations", CommonDataStore);
            Assert.IsTrue(locationResult.IsSuccess);
            var location = locationResult.Body.GetJObject()["value"][5];
            CommonDataStore.AddToDataStore("SelectedLocation", location, DataStoreType.Public);

            CommonDataStore.AddToDataStore("SelectedResourceGroup", "Test");
            var deleteResourceGroupResult = await TestHarness.ExecuteActionAsync("Microsoft-DeleteResourceGroup", CommonDataStore);

            var resourceGroupResult = await TestHarness.ExecuteActionAsync("Microsoft-CreateResourceGroup", CommonDataStore);
            Assert.IsTrue(resourceGroupResult.IsSuccess);

            return true;
        }

        public static void CreateTempDB()
        {
            CurrentDatabase = Guid.NewGuid().ToString();

            SqlCredentials creds = new SqlCredentials()
            {
                Server = Credential.Instance.Sql.Server,
                Username = Credential.Instance.Sql.Username,
                Password = Credential.Instance.Sql.Password,
                Authentication = SqlAuthentication.SQL,
                Database = "master"
            };

            string command = $"SET IMPLICIT_TRANSACTIONS OFF; " +
                             $"IF EXISTS (SELECT * FROM sys.databases WHERE name='{CurrentDatabase}') " +
                             $"DROP DATABASE [{CurrentDatabase}]; CREATE DATABASE [{CurrentDatabase}];";

            RunSqlCommandWithoutTransaction(creds, command);

            Credential.Instance.Sql.Database = CurrentDatabase;
        }

        public static void RemoveTempDB()
        {
            SqlCredentials creds = new SqlCredentials()
            {
                Server = Credential.Instance.Sql.Server,
                Username = Credential.Instance.Sql.Username,
                Password = Credential.Instance.Sql.Password,
                Authentication = SqlAuthentication.SQL,
                Database = "master"
            };
            
            string command = $"SET IMPLICIT_TRANSACTIONS OFF; " +
                            $"IF EXISTS (SELECT * FROM sys.databases WHERE name='{CurrentDatabase}') " +
                            $"DROP DATABASE [{CurrentDatabase}];";

            RunSqlCommandWithoutTransaction(creds, command);
        }

        private static ActionResponse GetSqlPagePayload(string database)
        {
            var dataStore = new DataStore();

            dynamic sqlPayload = new ExpandoObject();
            sqlPayload.SqlCredentials = new ExpandoObject();
            sqlPayload.SqlCredentials.Server = Credential.Instance.Sql.Server;
            sqlPayload.SqlCredentials.AuthType = "azuresql";
            sqlPayload.SqlCredentials.User = Credential.Instance.Sql.Username;
            sqlPayload.SqlCredentials.Password = Credential.Instance.Sql.Password;
            sqlPayload.SqlCredentials.Database = database;

            dataStore.AddObjectDataStore("SqlCredentials", JsonUtility.GetJObjectFromObject(sqlPayload), DataStoreType.Any);

            ActionResponse sqlResponse = TestHarness.ExecuteAction("Microsoft-GetSqlConnectionString", dataStore);
            Assert.IsTrue(sqlResponse.Status == ActionStatus.Success);
            return sqlResponse;
        }

        private static void RunSqlCommandWithoutTransaction(SqlCredentials creds, string commandText)
        {
            var connString = SqlUtility.GetConnectionString(creds).Replace("Connect Timeout=15", "Connect Timeout=60");
            using (var cn = new SqlConnection(connString))
            {
                cn.Open();
                using (var command = cn.CreateCommand())
                {
                    command.CommandTimeout = 60;
                    command.CommandText = commandText;
                    command.Transaction = null;
                    command.ExecuteNonQuery();
                }
                cn.Close();
            }
        }
    }
}
