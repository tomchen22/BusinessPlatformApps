using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Deployment.Actions.Test.TestHelpers;
using Microsoft.Deployment.Common.Helpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;

[assembly: InternalsVisibleTo("Microsoft.Deployment.Common.Helpers")]
namespace Microsoft.Deployment.Actions.Test.ActionsTest
{
    [TestClass]
    public class AzureServicesTests
    {
        [TestMethod]
        public async Task DeployAzureAnalysisServices()
        {
            var dataStore = await TestHarness.GetCommonDataStoreWithUserToken();
            dataStore.AddToDataStore("ASServerName", "asserver");
            dataStore.AddToDataStore("ASlocation", "westcentralus");
            dataStore.AddToDataStore("ASsku", "D1");
            dataStore.AddToDataStore("ASadmin", "admin@admin.com");

            var response = TestHarness.ExecuteAction("Microsoft-DeployAzureAnalysisServices", dataStore);
            Assert.IsTrue(response.IsSuccess);
        }
    }
}
