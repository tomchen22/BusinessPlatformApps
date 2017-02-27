using System;
using System.Linq;
using System.Threading;
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
        public void Given_CorrectInformation_When_RunTwitter_TheSuccess()
        {
            Given_CorrectCredentials_When_AzureAuth_Then_Success();
            HelperMethods.ClickNextButton();
            Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully();
            HelperMethods.ClickNextButton();
            Given_CorrectTwitterCredentials_When_Authenticating_Then_Success();
            Given_CorrectSearchTerms_When_Validating_Then_Success();
            HelperMethods.ClickNextButton();
            Given_CorrectHandles_When_Validating_Then_Success();
        }

        [TestMethod]
        public void Given_CorrectCredentials_When_AzureAuth_Then_Success()
        {
            HelperMethods.OpenWebBrowserOnPage("login");
            string username = Credential.Instance.ServiceAccount.Username;
            string password = Credential.Instance.ServiceAccount.Password;
            string subscriptionName = Credential.Instance.ServiceAccount.SubscriptionName;

            HelperMethods.AzurePage(username, password, subscriptionName);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [TestMethod]
        public void Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully()
        {
            string server = Credential.Instance.Sql.Server;
            string username = Credential.Instance.Sql.Username;
            string password = Credential.Instance.Sql.Password;
            string database = Credential.Instance.Sql.Database;

            //HelperMethods.OpenWebBrowserOnPage("source");
            HelperMethods.SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            HelperMethods.SelectSqlDatabase(database);
        }

        [TestMethod]
        public void Given_CorrectTwitterCredentials_When_Authenticating_Then_Success()
        {
            //HelperMethods.OpenWebBrowserOnPage("twitter");
            HelperMethods.ClickButton("Connect to Twitter");

            string username = Credential.Instance.TwitterAccount.Username;
            string password = Credential.Instance.TwitterAccount.Password;

            var usernameBox = driver.FindElementById("username_or_email");
            usernameBox.SendKeys(username);

            var passwordBox = driver.FindElementById("password");
            passwordBox.SendKeys(password);

            var authorizeButton = driver.FindElementById("allow");
            authorizeButton.Click();
        }

        [TestMethod]
        public void Given_CorrectSearchTerms_When_Validating_Then_Success()
        {
            HelperMethods.OpenWebBrowserOnPage("searchterms");
            string searchTerms = "@MSPowerBI OR Azure";

            var searchTermsInput = driver.FindElementByCssSelector("input[class='st-input au-target']");

            while (!searchTermsInput.Enabled)
            {
                Thread.Sleep(new TimeSpan(0, 0, 2));
            }

            searchTermsInput.SendKeys(searchTerms);

            HelperMethods.ClickValidateButton();

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [TestMethod]
        public void Given_CorrectHandles_When_Validating_Then_Success()
        {
            //HelperMethods.OpenWebBrowserOnPage("twitterhandles");
            string handles = "@MSPowerBI @Azure @Microsoft";

            var handlesInput = driver.FindElementByCssSelector("input[class='st-input au-target']");

            handlesInput.SendKeys(handles);

            HelperMethods.ClickValidateButton();

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            HelperMethods.ClickButton("Next");
            HelperMethods.ClickButton("Run");

            HelperMethods.CheckDeploymentStatus();
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
