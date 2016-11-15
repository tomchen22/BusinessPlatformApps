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
            string path = FileUtility.GetLocalTemplatePath(request.Info.AppName) + "\\..";
            
            if (Directory.Exists(path))
            {
                try
                {
                    RetryUtility.Retry(5, () =>
                    {
                        Directory.Delete(path, true);
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
