Write-Host "[" -NoNewline

# better to sort?
$completeWords = [System.Management.Automation.CommandCompletion]::CompleteInput($args[0].ToString(), $args[0].ToString().Length, $null).CompletionMatches
$cntCompleteWords = $completeWords.Count

foreach ($completeWord in $completeWords)
{
    Write-Host "{" -NoNewline
    Write-Host ("`"word`": `"" + $completeWord.CompletionText + "`", ") -NoNewline 
    Write-Host ("`"kind`": `"[" + $completeWord.ResultType + "]`", ") -NoNewline # must convert resulttype to single character?
    Write-Host ("`"menu`": `"" + $($($($completeWord.ToolTip -replace "\\","\\") -replace "^`r`n","") -replace "`r`n"," ") + "`"") -NoNewline 
    Write-Host "}," -NoNewline
}

Write-Host "]" -NoNewline

