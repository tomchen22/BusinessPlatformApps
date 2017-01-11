using System.ComponentModel.Composition;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AnalysisServices;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Server = Microsoft.AnalysisServices.Tabular.Server;

namespace Microsoft.Deployment.Actions.AzureCustom.AzureAS
{
    [Export(typeof(IAction))]
    public class DeployAzureASModel: BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string serverName = request.DataStore.GetValue("ASServerUrl");
            string username = request.DataStore.GetValue("ASAdmin") ??
                AzureUtility.GetEmailFromToken(request.DataStore.GetJson("AzureToken"));
            string password = request.DataStore.GetValue("ASAdminPassword");
            string xmla = request.DataStore.GetValue("xmlaFilePath");
            string asDatabase  = request.DataStore.GetValue("ASDatabase");

            string connectionString = string.Empty;

            if (serverName.ToLowerInvariant().StartsWith("asazure"))
            {
                connectionString += "Provider=MSOLAP;";
            }

            connectionString += $"Data Source={serverName};";

            if (!string.IsNullOrEmpty(password))
            {
                connectionString += $"User ID={username};Password={password};Persist Security Info=True; Impersonation Level=Impersonate;";
            }

            Server server = new Server();
            server.Connect(connectionString);

            string xmlaContents = File.ReadAllText(request.Info.App.AppFilePath + "/" +xmla);
            server.Execute(xmlaContents);
            var db = server.Databases.Find(asDatabase);
            db.Process(ProcessType.ProcessFull);
            return new ActionResponse(ActionStatus.Success);
        }
    }
}