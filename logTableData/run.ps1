using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata, $gslbTable, $poolTable)

# create log entries for App Insights logging/workbooks
$entries=$poolTable.Count
for ($n=0; $n -lt $entries; $n++) {
    $poolRow=$poolTable[$n] | convertTo-json
    write-host "{`"entries`" : $entries,`"poolData`" : $poolRow }"
}
$entries=$gslbTable.Count
for ($n=0; $n -lt $entries; $n++) {
    $gslbRow=$gslbTable[$n] | convertTo-json
    write-host "{`"entries`" : $entries,`"gslbData`" : $gslbRow }"
}

# create json response for HTTP requests..
$poolData = $poolTable | ConvertTo-Json
$gslbData = $gslbTable | ConvertTo-Json
$body= "{`r`n`"gslbconfig`" : {`r`n  `"poolData`" : " + $poolData + ",`r`n  `"gslbData`" : " + $gslbData + "`r`n  }`r`n}"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
