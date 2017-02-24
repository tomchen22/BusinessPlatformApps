using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;

namespace Microsoft.Deployment.Site.Web.Tests
{
    public class Helpers
    {
        public static string baseURL;
        public static RemoteWebDriver driver;
        
        public static void OpenWebBrowserOnPage(string page)
        {
            var url = baseURL + $"#/{page}";
            driver.Manage().Window.Maximize();
            driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(30));
            driver.Navigate().GoToUrl(url);
        }

        public static void ClickValidateButton()
        {
            var button = driver.FindElementsByTagName("Button").First(e => e.Text == "Validate");
            button.Click();
        }

        public static void ClickNextButton()
        {
            var button = driver.FindElementsByTagName("Button").First(e => e.Text == "Next");
            button.Click();
        }

        public static void ClickButton(string buttonText)
        {
            var button = driver.FindElementsByTagName("Button").FirstOrDefault(e => e.Text == buttonText);

            while (button == null || !button.Enabled)
            {
                button = driver.FindElementsByTagName("Button").FirstOrDefault(e => e.Text == buttonText);
                Thread.Sleep(1000);
            }

            var js = (IJavaScriptExecutor)driver;
            js.ExecuteScript("arguments[0].click()", button);
        }

        public static void AzurePage(string username, string password)
        {
            ClickButton("Connect to Azure");

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

        public static void SqlPageExistingDatabase(string server, string username, string password)
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

        public static void SelectSqlDatabase(string databaseName)
        {
            var database = driver.FindElementsByCssSelector("select[class='btn btn-default dropdown-toggle st-input au-target']")
                            .FirstOrDefault(e => !e.Text.Contains("Windows"));

            while (database == null)
            {
                database = driver.FindElementsByCssSelector("select[class='btn btn-default dropdown-toggle st-input au-target']")
                            .FirstOrDefault(e => !e.Text.Contains("Windows"));
            }
            database.SendKeys(databaseName);
        }
    }
}
