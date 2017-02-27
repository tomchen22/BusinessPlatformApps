using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;

namespace Microsoft.Deployment.Site.Web.Tests
{
    [TestClass]
    [Ignore]
    public class SalesforceSalesManagementTests
    {
        private string baseURL = Constants.Host + "?name=Microsoft-SalesforceSalesManagement";
        private RemoteWebDriver driver;
        private string browser;


        [TestMethod]
        public void NavigateToAzurePage()
        {
            OpenWebBrowserOnPage(string.Empty);
            var element = driver.FindElementByTagName("Button");
            element.Click();
        }

        [TestMethod]
        public void Given_CorrectAzureCredentials_When_Connect_Then_Success()
        {
            OpenWebBrowserOnPage("azure");
            string username = "mohaali@pbist.onmicrosoft.com";
            string password = "Corp123!";
            AzurePage(username, password);
        }

        [TestMethod]
        public void Given_CorrectSalesforceCredentials_When_Validate_Then_PageValidatesSuccesfully()
        {
            OpenWebBrowserOnPage("salesforce");

            string username = "cat@catinc.com";
            string password = "P@ssw0rd";
            string token = "d9grDLHpwPGmg0f5UewyZD11";

            SalesforcePage(username, password, token);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [TestMethod]
        public void Given_NoSalesforceCredentials_When_Validate_Then_PageFailsWithErrorMessage()
        {
            OpenWebBrowserOnPage("salesforce");

            SalesforcePage(string.Empty, string.Empty, string.Empty);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "INVALID_LOGIN: Invalid username, password, security token; or user locked out.");
        }

        [TestMethod]
        public void Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully()
        {
            this.OpenWebBrowserOnPage("target");

            string server = "pbisttest";
            string username = "pbiadmin";
            string password = "Billing.26";

           SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [TestMethod]
        public void Given_WrongSqlCredentials_When_ExistingSqlSelected_Then_PageFailsWithErrorMessage()
        {
            this.OpenWebBrowserOnPage("target");

            this.OpenWebBrowserOnPage("target");

            string server = "pbist";
            string username = "testuser";
            string password = "testpassword";

            SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Login to SQL failed");
        }

        [Ignore]
        [TestMethod]
        public void Given_AllCorrectInformation_When_Deploying_Then_ExperienceCompletesSuccessfully()
        {
            OpenWebBrowserOnPage(string.Empty);
            ClickNextButton();

            Thread.Sleep(new TimeSpan(0, 0, 10));

            string username = "mohaali@pbist.onmicrosoft.com";
            string password = "Corp123!";
            AzurePage(username, password);

            Thread.Sleep(new TimeSpan(0, 0, 10));

            var checkBox = driver.FindElementsByCssSelector("input[class='au-target']").First(e => e.GetAttribute("type") == "checkbox");
            checkBox.Click();

            ClickNextButton();

            string sfusername = "cat@catinc.com";
            string sfpassword = "P@ssw0rd";
            string sftoken = "d9grDLHpwPGmg0f5UewyZD11";

            SalesforcePage(sfusername, sfpassword, sftoken);

            var sfvalidated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(sfvalidated.Text == "Successfully validated");

            ClickNextButton();

            string sqlserver = "pbist";
            string sqlusername = "pbiadmin";
            string sqlpassword = "Billing.26";

            SqlPageExistingDatabase(sqlserver, sqlusername, sqlpassword);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            ClickNextButton();
        }

        [TestCleanup]
        public void Cleanup()
        {
            driver.Quit();
        }

        [TestInitialize]
        public void MyTestInitialize()
        {
        }

        public void AzurePage(string username, string password)
        {
            var elements = driver.FindElementByTagName("Button");
            elements.Click();

            var usernameBox = driver.FindElementById("cred_userid_inputtext");
            usernameBox.SendKeys(username);

            var passwordBox = driver.FindElementById("cred_password_inputtext");
            passwordBox.SendKeys(password);

            Thread.Sleep(new TimeSpan(0, 0, 1));
            var signInButton = driver.FindElementById("cred_sign_in_button");

            var js = (IJavaScriptExecutor)driver;
            js.ExecuteScript("arguments[0].click()", signInButton);

            Thread.Sleep(new TimeSpan(0, 0, 1));
            var acceptButton = driver.FindElementById("cred_accept_button");
            acceptButton.Click();
        }

        public void SalesforcePage(string username, string password, string token)
        {
            var usernameBox =
                driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "username");
            usernameBox.SendKeys(username);
            var passwordBox =
                driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "password");
            passwordBox.SendKeys(password);
            var tokenBox =
                driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "token");
            tokenBox.SendKeys(token);

            ClickValidateButton();
        }

        public void SqlPageExistingDatabase(string server, string username, string password)
        {
            var option = driver.FindElementByCssSelector("select[class='btn btn-default dropdown-toggle st-input au-target']");
            option.SendKeys("Existing SQL Instance");

            var elements = driver.FindElementsByCssSelector("input[class='st-input au-target']");

            var serverBox = elements.First(e => e.GetAttribute("value.bind").Contains("sqlServer"));
            serverBox.SendKeys(server);

            var usernameBox = elements.First(e => e.GetAttribute("value.bind").Contains("username"));
            usernameBox.SendKeys(username);

            var passwordBox = elements.First(e => e.GetAttribute("value.bind").Contains("password"));
            passwordBox.SendKeys(password);

            ClickValidateButton();
        }

        public void OpenWebBrowserOnPage(string page)
        {
            var url = this.baseURL + $"#/{page}";
            driver = new ChromeDriver();
            driver.Manage().Window.Maximize();
            driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(30));
            driver.Navigate().GoToUrl(url);
        }

        public void ClickValidateButton()
        {
            var button = driver.FindElementsByTagName("Button").First(e => e.Text == "Validate");
            button.Click();
        }

        public void ClickNextButton()
        {
            var button = driver.FindElementsByTagName("Button").First(e => e.Text == "Next");
            button.Click();
        }
    }
}
