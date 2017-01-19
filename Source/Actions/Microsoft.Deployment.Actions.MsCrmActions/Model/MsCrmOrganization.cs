namespace Microsoft.Deployment.Common.Actions.MsCrm.Model
{
    using Newtonsoft.Json;

#pragma warning disable 0649
    public class MsCrmOrganization
    {
        public string OrganizationName;
        public string OrganizationUrl;
        public string OrganizationId;
        public string ConnectorUrl;

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public int ErrorCategory;

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public int ErrorCode;

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string ErrorMessage;

    }
#pragma warning restore 0649
}