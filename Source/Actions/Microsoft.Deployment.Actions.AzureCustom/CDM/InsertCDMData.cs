using System.Threading.Tasks;


namespace Microsoft.Deployment.Actions.AzureCustom.CDM
{
    using System;
    using System.ComponentModel.Composition;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.D365.Cdm.CommonEntities;
    using Microsoft.D365.Cdm.Entities;
    using Microsoft.D365.Cdm.Modeling;
    using Deployment.Common.Actions;
    using Deployment.Common.ActionModel;

    [Export(typeof(IAction))]
    public class InsertCDMData : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {

            return new ActionResponse(ActionStatus.Success);
        }
    }
}
