using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Management.Automation;

namespace PoshComplete
{
	class Program
	{
		static void Main(string[] args)
		{
			var ps = PowerShell.Create();
			var line = args.Length > 0 ? args[0] : Console.ReadLine();
			var candidates = CommandCompletion.CompleteInput(line, line.Length, null, ps).CompletionMatches;
			foreach (var cand in candidates)
			{
				var str = string.Format("{{\"word\": \"{0}\", \"kind\": \"[{1}]\", \"menu\": \"{2}\"}}",
					cand.CompletionText.Replace("'", ""),
					cand.ResultType,
					cand.ToolTip.Replace("\r\n", ""));
				Console.WriteLine(str);
			}
		}
	}
}
