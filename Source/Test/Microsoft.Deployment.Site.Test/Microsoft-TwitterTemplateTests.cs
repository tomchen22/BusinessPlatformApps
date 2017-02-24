using System;
using Microsoft.Deployment.Site.Test.TestHelpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;

namespace Microsoft.Deployment.Site.Web.Tests
{
    [TestClass]
    public class TwitterTemplateTests
    {
        private string baseURL = Constants.Slot3;
        private RemoteWebDriver driver;
        private string browser;

        [TestMethod]
        public void Given_CorrectCredentials_When_AzureAuth_Then_Success()
        {
            HelperMethods.OpenWebBrowserOnPage("login");
            string username = "";
            string password = "";
            HelperMethods.AzurePage(username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            HelperMethods.ClickNextButton();
        }

        [TestMethod]
        public void Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully()
        {
            string server = Credential.Instance.Sql.Server;
            string username = Credential.Instance.Sql.Username;
            string password = Credential.Instance.Sql.Password;
            string database = Credential.Instance.Sql.Database;

            HelperMethods.OpenWebBrowserOnPage("source");
            HelperMethods.SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            HelperMethods.SelectSqlDatabase(database);

            HelperMethods.ClickNextButton();
        }

        [TestMethod]
        public void Given_CorrectTwitterCredentials_When_Authenticating_Then_Success()
        {
            HelperMethods.OpenWebBrowserOnPage("twitter");
            HelperMethods.ClickButton("Connect to Twitter");

            string username = "asdasd";
            string password = "asdas";

            var usernameBox = driver.FindElementById("username_or_email");
            usernameBox.SendKeys(username);

            var passwordBox = driver.FindElementById("password");
            passwordBox.SendKeys(password);

            var authorizeButton = driver.FindElementById("allow");
            authorizeButton.Click();               
        }

        [TestMethod]
        public void TestAzurePageFlowCredentials()
        {
            var url = this.baseURL + "#/azure";
            driver = new ChromeDriver();
            driver.Manage().Window.Maximize();
            driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(30));
            driver.Navigate().GoToUrl(url);
            var elements = driver.FindElementByTagName("Button");
            elements.Click();

            string username = "";
            string password = "";
        }

        [TestCleanup()]
        public void MyTestCleanup()
        {
            HelperMethods.driver.Quit();
        }

        [TestInitialize]
        public void Initialize()
        {
            Credential.Load();
            HelperMethods.baseURL = baseURL + "?name=Microsoft-TwitterTemplate";
            HelperMethods.driver = new ChromeDriver();
            this.driver = HelperMethods.driver;
        }
    }
}
