using Newtonsoft.Json;

namespace Microsoft.Deployment.Common.Model.Scribe
{
    public class ScribeOrganization : ScribeObject
    {
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string OrganizationURL;

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string ConnectorURL;

        [JsonProperty("apiToken")]
        public string ApiToken;
    }
}