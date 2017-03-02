using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Tests.Actions.TestHelpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Microsoft.Deployment.Tests.Actions.OnPrem
{
    [TestClass]
    [Ignore]
    public class VersionTests
    {
        [TestMethod]
        public void CheckVersion()
        {
            var dataStore = new DataStore();
            var response = TestManager.ExecuteActionAsync("Microsoft-CheckVersion", dataStore).Result;
        }
    }
}
