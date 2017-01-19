namespace Microsoft.Deployment.Common.Actions.MsCrm
{
    using Microsoft.Deployment.Common.ActionModel;
    using Microsoft.Deployment.Common.Actions;
    using Microsoft.Deployment.Common.Helpers;
    using Model;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System;
    using System.ComponentModel.Composition;
    using System.Dynamic;
    using System.Net;
    using System.Net.Http.Headers;
    using System.Threading.Tasks;

    [Export(typeof(IAction))]
    public class CrmGetOrgs : BaseAction
    {
        public override async Task<ActionResponse> ExecuteActionAsync(ActionRequest request)
        {
            string token = request.DataStore.GetJson("MsCrmToken")["access_token"].ToString();

            AuthenticationHeaderValue bearer = new AuthenticationHeaderValue("Bearer", token);

            RestClient rc = new RestClient(MsCrmEndpoints.ENDPOINT, bearer);
            string response = await rc.Get(MsCrmEndpoints.URL_ORGANIZATIONS);
            MsCrmOrganization[] orgs = JsonConvert.DeserializeObject<MsCrmOrganization[]>(response);

            for (int i = 0; i < orgs.Length; i++)
            {
                try
                {
                    response = await rc.Get(MsCrmEndpoints.URL_ORGANIZATION_METADATA, $"organizationUrl={WebUtility.UrlEncode(orgs[i].OrganizationUrl)}");
                }
                catch (Exception e)
                {
                    string dynamics365Error = e.Message ?? string.Empty;
                    return dynamics365Error.ToLower().Contains("failed authorization")
                        ? new ActionResponse(ActionStatus.Failure, new JObject(), "MsCrm_Unauthorized")
                        : new ActionResponse(ActionStatus.Failure, new JObject(), e, "MsCrm_MetadataError", dynamics365Error);
                }
                orgs[i] = JsonConvert.DeserializeObject<MsCrmOrganization>(response);
            }

            // This is a bit of a dance to accomodate ActionResponse and its need for a JObject
            response = JsonConvert.SerializeObject(orgs);

            dynamic d = new ExpandoObject();
            return string.IsNullOrWhiteSpace(response)
                ? new ActionResponse(ActionStatus.Failure, new JObject(), "MsCrm_NoOrgs")
                : new ActionResponse(ActionStatus.Success, JsonUtility.GetJObjectFromStringValue(response));
        }
    }
}