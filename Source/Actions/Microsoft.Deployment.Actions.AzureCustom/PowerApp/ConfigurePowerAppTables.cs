using System.ComponentModel.Composition;
using System.Threading.Tasks;

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

            bool isAdvanced = false;

            SqlUtility.InvokeSqlCommand(sqlConnectionString, string.Format(INSERT_INTO_TWITTER_QUERY, 1, isAdvanced ? 1 : 0, searchQuery, null), null);

            return new ActionResponse(ActionStatus.Success, JsonUtility.GetEmptyJObject());
        }
    }
}