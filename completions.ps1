

if ($args[0] -ne $null) {
    $inputText = $args[0].ToString()

    Write-Host "[" -NoNewline

    # better to sort?
    $completeWords = [System.Management.Automation.CommandCompletion]::CompleteInput($inputText, $inputText.Length, $null).CompletionMatches | Select-Object CompletionText, ResultType, ToolTip
    $cntCompleteWords = $completeWords.Count

    foreach ($completeWord in $completeWords)
    {
        Write-Host "{" -NoNewline
        Write-Host ("`"word`": `"" + $($completeWord.CompletionText -replace "\\","\\") + "`", ") -NoNewline 
        Write-Host ("`"kind`": `"[" + $completeWord.ResultType + "]`", ") -NoNewline # must convert resulttype to single character?
        Write-Host ("`"menu`": `"" + $($($($completeWord.ToolTip -replace "\\","\\") -replace "^`r`n","") -replace "`r`n"," ") + "`"") -NoNewline 
        Write-Host "}," -NoNewline
    }

    Write-Host "]" -NoNewline
}
