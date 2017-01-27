using System;
using System.ComponentModel.Composition;
using System.Threading.Tasks;
using System.Text;

using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.AzureCustom.PowerApp
{
    [Export(typeof(IAction))]
    public class ConfigurePowerAppTables : BaseAction
    {
        private const string INSERT_INTO_TWITTER_QUERY = "INSERT INTO [pbist_twitter].[twitter_query] ([Id], [IsAdvanced], [QueryString], [TweetId]) VALUES ({0}, {1}, '{2}', {3})";
        private const string INSERT_INTO_TWITTER_QUERY_DETAILS = "INSERT INTO [pbist_twitter].[twitter_query_details] ([Id], [ReadableId], [Operator], [Operand]) VALUES ({0}, {1}, '{2}', '{3}')";
        private const string INSERT_INTO_TWITTER_QUERY_READABLE = "INSERT INTO [pbist_twitter].[twitter_query_readable] ([Id], [QueryId], [QueryReadable], [Query]) VAULES ({0}, {1}, '{2}', '{3}')";

        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string searchQuery = request.DataStore.GetValue("SearchQuery") ?? string.Empty;
            string sqlConnectionString = request.DataStore.GetValueAtIndex("SqlConnectionString", "SqlServerIndex");

            bool isAdvanced = IsAdvancedTwitterQuery(searchQuery);

            SqlUtility.InvokeSqlCommand(sqlConnectionString, string.Format(INSERT_INTO_TWITTER_QUERY, 1, isAdvanced ? 1 : 0, searchQuery, null), null);

            if (!isAdvanced)
            {
                string[] conditions = searchQuery.Split(new string[] { "OR" }, StringSplitOptions.None);
                for (int i = 0; i < conditions.Length; i++)
                {
                    string condition = conditions[i].Trim();
                    StringBuilder sb = new StringBuilder();
                    for (int j = 0; j < condition.Length; j++)
                    {
                        // do stuff
                    }
                }
            }

            return new ActionResponse(ActionStatus.Success, JsonUtility.GetEmptyJObject());
        }

        private bool IsAdvancedTwitterQuery(string query)
        {
            bool isAdvanced = false;

            bool isOpenBracket = false;
            bool isOpenQuote = false;

            for (int i = 0; i < query.Length && !isAdvanced; i++)
            {
                switch (query[i])
                {
                    case '"':
                        isOpenQuote = !isOpenQuote;
                        break;
                    case '(':
                        if (!isOpenQuote)
                        {
                            if (isOpenBracket)
                            {
                                isAdvanced = true;
                            }
                            else
                            {
                                isOpenBracket = true;
                            }
                        }
                        break;
                    case ')':
                        if (!isOpenQuote)
                        {
                            if (isOpenBracket)
                            {
                                isOpenBracket = false;
                            }
                            else
                            {
                                isAdvanced = true;
                            }
                        }
                        break;
                    case 'O':
                        if (!isOpenQuote && i < query.Length - 1 && query[i + 1] == 'R')
                        {
                            isAdvanced = isOpenBracket;
                        }
                        break;
                    default:
                        break;
                }
            }

            return isAdvanced;
        }
    }
}