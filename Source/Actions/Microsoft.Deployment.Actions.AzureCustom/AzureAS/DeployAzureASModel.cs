﻿using System.ComponentModel.Composition;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AnalysisServices;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;
using RefreshType = Microsoft.AnalysisServices.Tabular.RefreshType;
using Server = Microsoft.AnalysisServices.Tabular.Server;

namespace Microsoft.Deployment.Actions.AzureCustom.AzureAS
{
    [Export(typeof(IAction))]
    public class DeployAzureASModel : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string xmla = request.DataStore.GetValue("xmlaFilePath");
            string asDatabase = request.DataStore.GetValue("ASDatabase");
            string sqlConnectionString = request.DataStore.GetValue("SqlConnectionString");
            var connectionStringObj = SqlUtility.GetSqlCredentialsFromConnectionString(sqlConnectionString);
            string connectionString = request.DataStore.GetValue("ASConnectionString");

            Server server = new Server();
            server.Connect(connectionString);
           
            string xmlaContents = File.ReadAllText(request.Info.App.AppFilePath + "/" + xmla);

            var obj = JsonUtility.GetJsonObjectFromJsonString(xmlaContents);
            obj["create"]["database"]["name"] = asDatabase;
            //obj["create"]["database"]["model"]["dataSources"][0]["name"] = "Sql Connection for" + asDatabase;
            obj["create"]["database"]["model"]["dataSources"][0]["connectionString"] =
                $"Provider=SQLNCLI11.1;Persist Security Info=False;User ID={connectionStringObj.Username};Password={connectionStringObj.Password};" +
                $"Initial Catalog={connectionStringObj.Database};Data Source=tcp:{connectionStringObj.Server};Initial File Name=;Server SPN=";


            //Delete existing
            var db = server.Databases.Find(asDatabase);
            db?.Drop(DropOptions.Default);
            server.Refresh(true);

            //Deploy 
            var response = server.Execute(obj.ToString());
            if (response.ContainsErrors)
            {
                return new ActionResponse(ActionStatus.Failure, response[0].Value);
            }

            server = new Server();
            server.Connect(connectionString);
            db = server.Databases.Find(asDatabase);
            if (db == null)
            {
                return new ActionResponse(ActionStatus.Failure, string.Empty, null, null,"AS Database was not deployed");
            }

            return new ActionResponse(ActionStatus.Success);
        }
    }
}