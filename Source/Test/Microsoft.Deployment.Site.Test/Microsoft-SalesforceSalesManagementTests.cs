﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Deployment.Site.Test.TestHelpers;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;

namespace Microsoft.Deployment.Site.Web.Tests
{
    [TestClass]
    public class SalesforceSalesManagementTests
    {
        private string baseURL = Constants.Slot3;
        private RemoteWebDriver driver;

        [TestMethod]
        public void Given_CorrectInformation_And_No_AS_When_RunSalesforce_ThenSuccess()
        {
            Given_CorrectCredentials_When_AzureAuth_Then_Success();
            HelperMethods.ClickNextButton();
            Given_CorrectSalesforceCredentials_When_Validate_Then_PageValidatesSuccesfully();
            HelperMethods.ClickNextButton();
            Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully();
            HelperMethods.ClickNextButton();
            HelperMethods.NoAnalysisServices();
            HelperMethods.ClickNextButton();
            Thread.Sleep(new TimeSpan(0, 0, 3));
            HelperMethods.ClickNextButton();
            HelperMethods.ClickButton("Run");
            HelperMethods.CheckDeploymentStatus();
            HelperMethods.CleanSubscription(
                          Credential.Instance.ServiceAccount.Username,
                          Credential.Instance.ServiceAccount.Password,
                          Credential.Instance.ServiceAccount.TenantId,
                          Credential.Instance.ServiceAccount.ClientId,
                          Credential.Instance.ServiceAccount.SubscriptionId);

        }

        [TestMethod]
        public void Given_CorrectInformation_And_AS_When_RunSalesforce_ThenSuccess()
        {
            Given_CorrectCredentials_When_AzureAuth_Then_Success();
            HelperMethods.ClickNextButton();
            Given_CorrectSalesforceCredentials_When_Validate_Then_PageValidatesSuccesfully();
            HelperMethods.ClickNextButton();
            Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully();
            HelperMethods.ClickNextButton();
            HelperMethods.NewAnalysisServices("salesforceas", Credential.Instance.ServiceAccount.Username, Credential.Instance.ServiceAccount.Password);
            HelperMethods.ClickNextButton();
            Thread.Sleep(new TimeSpan(0, 0, 3));
            HelperMethods.ClickNextButton();
            HelperMethods.ClickNextButton();
            HelperMethods.ClickButton("Run");
            HelperMethods.CheckDeploymentStatus();
            HelperMethods.CleanSubscription(
                          Credential.Instance.ServiceAccount.Username,
                          Credential.Instance.ServiceAccount.Password,
                          Credential.Instance.ServiceAccount.TenantId,
                          Credential.Instance.ServiceAccount.ClientId,
                          Credential.Instance.ServiceAccount.SubscriptionId);

        }


        [TestMethod]
        [Ignore]
        public void Given_CorrectCredentials_When_AzureAuth_Then_Success()
        {
            HelperMethods.OpenWebBrowserOnPage("azure");
            string username = Credential.Instance.ServiceAccount.Username;
            string password = Credential.Instance.ServiceAccount.Password;
            string subscriptionName = Credential.Instance.ServiceAccount.SubscriptionName;

            HelperMethods.AzurePage(username, password, subscriptionName);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [Ignore]
        [TestMethod]
        public void Given_CorrectSalesforceCredentials_When_Validate_Then_PageValidatesSuccesfully()
        {
            string username = Credential.Instance.Salesforce.Username;
            string password = Credential.Instance.Salesforce.Password;
            string token = Credential.Instance.Salesforce.Token;

            SalesforcePage(username, password, token);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");
        }

        [Ignore]
        [TestMethod]
        public void Given_NoSalesforceCredentials_When_Validate_Then_PageFailsWithErrorMessage()
        {
            HelperMethods.OpenWebBrowserOnPage("salesforce");

            SalesforcePage(string.Empty, string.Empty, string.Empty);

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "INVALID_LOGIN: Invalid username, password, security token; or user locked out.");
        }

        [TestMethod]
        [Ignore]
        public void Given_CorrectSqlCredentials_When_ExistingSqlSelected_Then_PageValidatesSuccessfully()
        {
            string server = Credential.Instance.Sql.Server;
            string username = Credential.Instance.Sql.Username;
            string password = Credential.Instance.Sql.Password;
            string database = Credential.Instance.Sql.SalesforceDatabase;

            HelperMethods.SqlPageExistingDatabase(server, username, password);

            Thread.Sleep(new TimeSpan(0, 0, 3));

            var validated = driver.FindElementByClassName("st-validated");

            Assert.IsTrue(validated.Text == "Successfully validated");

            HelperMethods.SelectSqlDatabase(database);
        }

        [Ignore]
        [TestMethod]
        public void Given_WrongSqlCredentials_When_ExistingSqlSelected_Then_PageFailsWithErrorMessage()
        {
            HelperMethods.OpenWebBrowserOnPage("target");

            string server = Credential.Instance.Sql.Server;
            string username = Credential.Instance.Sql.Username;
            string password = "wrongPassword";

            HelperMethods.SqlPageExistingDatabase(server, username, password);

            var validated = driver.FindElementByClassName("st-validated");
            Assert.IsTrue(validated.Text == "Login to SQL failed");
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
            HelperMethods.baseURL = baseURL + "?name=Microsoft-SalesforceSalesManagement";
            var options = new ChromeOptions();
            options.AddArgument("no-sandbox");
            HelperMethods.driver = new ChromeDriver(options);
            this.driver = HelperMethods.driver;
        }

        public void SalesforcePage(string username, string password, string token)
        {
            var usernameBox =
                driver.FindElementsByTagName("Input").FirstOrDefault(e => e.GetAttribute("placeholder") == "username");
            var passwordBox =
                driver.FindElementsByTagName("Input").FirstOrDefault(e => e.GetAttribute("placeholder") == "password");
            var tokenBox =
                driver.FindElementsByTagName("Input").FirstOrDefault(e => e.GetAttribute("placeholder") == "token");

            while(usernameBox == null && passwordBox == null && tokenBox == null)
                
            {
                Thread.Sleep(new TimeSpan(0, 0, 3));
                usernameBox =
                  driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "username");
                passwordBox =
                    driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "password");
                tokenBox =
                    driver.FindElementsByTagName("Input").First(e => e.GetAttribute("placeholder") == "token");
            }

            while (usernameBox.Enabled != true && passwordBox.Enabled != true && tokenBox.Enabled != true)
            {
                Thread.Sleep(new TimeSpan(0, 0, 3));
            }

            tokenBox.SendKeys(token);
            usernameBox.SendKeys(username);
            passwordBox.SendKeys(password);
            HelperMethods.ClickValidateButton();
        }
    }
}
