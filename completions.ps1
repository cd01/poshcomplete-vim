if ($args[0] -ne $null) {
    $inputText = $args[0].ToString()

    $completeWords = [System.Management.Automation.CommandCompletion]::CompleteInput($inputText, $inputText.Length, $null).CompletionMatches | Select-Object CompletionText, ResultType, ToolTip

    foreach ($completeWord in $completeWords)
    {
        Write-Host "{" `
            ("`"word`": `"" + ($completeWord.CompletionText -replace "\\","\\") + "`", ") `
            ("`"kind`": `"[" + $completeWord.ResultType + "]`", ") `
            ("`"menu`": `"" + ($($($completeWord.ToolTip -replace "\\","\\") -replace "^`r`n","") -replace "`r`n"," ") + "`"") `
            "}"
    }
}

# vim:set et ts=4 sts=0 sw=4 ff=dos:

