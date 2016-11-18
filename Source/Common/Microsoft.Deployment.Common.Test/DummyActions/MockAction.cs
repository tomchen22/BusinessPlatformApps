using System.ComponentModel.Composition;
using System.Threading.Tasks;

using Microsoft.Deployment.Common.ActionModel;
using Microsoft.Deployment.Common.Actions;

namespace Microsoft.Deployment.Common.Test.DummyActions
{
    [Export(typeof(IAction))]
    public class MockAction : BaseAction
    {
#pragma warning disable CS1998 // Async method lacks 'await' operators and will run synchronously
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
#pragma warning restore CS1998 // Async method lacks 'await' operators and will run synchronously
        {
            return new ActionResponse(ActionStatus.Success, "Hello"); 
        }
    }
}