using System.ComponentModel.Composition;
using System.Threading.Tasks;

using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;
using Microsoft.Deployment.Common.Helpers;

namespace Microsoft.Deployment.Actions.Common
{
    [Export(typeof(IAction))]
    public class EmailSubscription : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string emailAddress = request.DataStore.GetValue("EmailAddress");
            string nameFirst = request.DataStore.GetValue("NameFirst");
            string nameLast = request.DataStore.GetValue("NameLast");

            request.Logger.LogEmailSubscription(emailAddress, nameFirst, nameLast);

            return new ActionResponse(ActionStatus.Invisible, JsonUtility.GetEmptyJObject());
        }
    }
}