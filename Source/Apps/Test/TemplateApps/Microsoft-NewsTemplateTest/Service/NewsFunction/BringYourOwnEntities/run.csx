#r "Newtonsoft.Json"

using System;
using System.Configuration;
using System.Net;
using Newtonsoft.Json;

public static async Task<object> Run(HttpRequestMessage req, TraceWriter log)
{
    log.Info($"Webhook was triggered!");

    string jsonContent = await req.Content.ReadAsStringAsync();
    dynamic data = JsonConvert.DeserializeObject(jsonContent);

    dynamic regularExpressions;

    try
    {
        regularExpressions = JsonConvert.DeserializeObject(ConfigurationManager.AppSettings["RegularExpressions"]);
    }
    catch (Exception e)
    {
        return req.CreateResponse(HttpStatusCode.BadRequest, new {
            error = "Error retrieving appsetting 'RegularExpressions'.  Please ensure that the setting is defined and in the correct format. " + e.ToString()});
    }

    if (data.text == null) {
        return req.CreateResponse(HttpStatusCode.BadRequest, new {
            error = "Please pass text property in the input object"
        });
    }

    return req.CreateResponse(HttpStatusCode.OK, new {
        greeting = $"Hello {data.text}!"
    });
}
