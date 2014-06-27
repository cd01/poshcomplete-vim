using Nancy.Hosting.Self;
using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Runtime.Serialization.Json;
using System.Text;


namespace PoshComplete
{
	class Program
	{
		static void Main(string[] args)
		{
            using (var nancyHost = new NancyHost(new Uri("http://localhost:1234")))
            {
                nancyHost.Start();
                Console.ReadLine();
                nancyHost.Stop();
            }
		}
	}
 
    public class SampleModule : Nancy.NancyModule
    {
        public SampleModule()
        {
            Get["/poshcomplete/{inputText}"] = (query) =>
            {
                var serializer = new DataContractJsonSerializer(typeof(List<Candidate>));
                using (var ms = new System.IO.MemoryStream())
                {
                    string line = query.inputText;
                    var candidates = CommandCompletion.CompleteInput(line, line.Length, null, PowerShell.Create()).CompletionMatches;
                    List<Candidate> list = new List<Candidate>();

                    foreach (var cand in candidates)
                    {
                        list.Add(new Candidate() {
                                                    word = cand.CompletionText.Replace("'", ""),
                                                    kind = cand.ResultType.ToString(),
                                                    menu = cand.ToolTip.Replace("\r\n", "")
                                                  });
                    }
                    
                    serializer.WriteObject(ms, list);

                    return Encoding.UTF8.GetString(ms.ToArray(), 0, (int)ms.Length);
                }
            };
        }
    }

    public class Candidate
    {
        public string word { get; set; }
        public string kind { get; set; }
        public string menu { get; set; }
    }
}
