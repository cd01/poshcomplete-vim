if ($args[0] -ne $null) {
    $inputText = $args[0].ToString()

    Write-Host "[" -NoNewline

    $completeWords = [System.Management.Automation.CommandCompletion]::CompleteInput($inputText, $inputText.Length, $null).CompletionMatches | Select-Object CompletionText, ResultType, ToolTip

    foreach ($completeWord in $completeWords)
    {
        Write-Host "{" -NoNewline
        Write-Host ("`"word`": `"" + $($completeWord.CompletionText -replace "\\","\\") + "`", ") -NoNewline 
        Write-Host ("`"kind`": `"[" + $completeWord.ResultType + "]`", ") -NoNewline
        Write-Host ("`"menu`": `"" + $($($($completeWord.ToolTip -replace "\\","\\") -replace "^`r`n","") -replace "`r`n"," ") + "`"") -NoNewline 
        Write-Host "}," -NoNewline
    }

    Write-Host "]" -NoNewline
}

# vim:set et ts=4 sts=0 sw=4 ff=dos:

