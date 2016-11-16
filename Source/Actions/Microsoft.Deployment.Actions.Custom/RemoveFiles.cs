using System;
using System.ComponentModel.Composition;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.Custom
{
    [Export(typeof(IAction))]
    public class RemoveFiles : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string targetPath = request.DataStore.GetValue("TargetPath") == null
                                ? FileUtility.GetLocalTemplatePath(request.Info.AppName)
                                : request.DataStore.GetValue("TargetPath");

            if (Directory.Exists(targetPath))
            {
                try
                {
                    RetryUtility.Retry(5, () =>
                    {
                        Directory.Delete(targetPath, true);
                        Thread.Sleep(500);
                    });

                    return new ActionResponse(ActionStatus.Success, JsonUtility.GetEmptyJObject());
                }
                catch (Exception ex)
                {
                    return new ActionResponse(ActionStatus.Failure, ex);
                }
            }
            return new ActionResponse(ActionStatus.Success, JsonUtility.GetEmptyJObject());
        }
    }
}