using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
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
            Helpers.OpenWebBrowserOnPage("login");
            string username = "mohaali@pbist.onmicrosoft.com";
            string password = "Corp123!";
            Helpers.AzurePage(username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            Helpers.ClickNextButton();
        }

        [TestMethod]
        public void Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully()
        {
            Helpers.OpenWebBrowserOnPage("source");
            string server = "pbisttest";
            string username = "pbiadmin";
            string password = "Billing.26";
            Helpers.SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            Helpers.SelectSqlDatabase("catdorTest");

            Helpers.ClickNextButton();
        }

        [TestMethod]
        public void Given_CorrectTwitterCredentials_When_Authenticating_Then_Success()
        {
            Helpers.OpenWebBrowserOnPage("twitter");
            Helpers.ClickButton("Connect to Twitter");

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

            string username = "mohaali@pbist.onmicrosoft.com";
            string password = "Corp123!";

        }

        [TestCleanup()]
        public void MyTestCleanup()
        {
            Helpers.driver.Quit();
        }

        [TestInitialize]
        public void Initialize()
        {
            Helpers.baseURL = baseURL + "?name=Microsoft-TwitterTemplate";
            Helpers.driver = new ChromeDriver();
            this.driver = Helpers.driver;
        }
    }
}
