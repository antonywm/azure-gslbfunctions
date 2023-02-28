using namespace System.Net
# Input bindings are passed in via param block.
param($QueueItem, $TriggerMetadata)

# Write out the queue message and insertion time to the information log.
Write-Host "PowerShell queue trigger function processed work item: $QueueItem"
Write-Host "Queue item insertion time: $($TriggerMetadata.InsertionTime)"

$CName = $QueueItem.CName
$RecordName = $QueueItem.RecordName
$TTL = $QueueItem.TTL
$action = $QueueItem.action

if($action -eq "delete"){
    $DeleteRecord = $true
}
if(-Not($TTL)){$TTL=60}

$clientId = "6c9e26c6-ba7e-47b9-a13e-37bea3750b56"
$tenantId = "b6796c65-d56b-4fc1-9798-f7e98c230e36"
$clientSecret = '7De8Q~3-pglr2.UiCIJ6H7en.kUAawND3UuzLaKd'
$AuthURI = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientId
    scope         = "https://management.core.windows.net/.default"
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Get OAuth Access Token
$tokenRequest = Invoke-WebRequest -Method Post -Uri $AuthURI -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
# Set Access Token
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token

# RESOURCE INFORMATION
$subscriptionId="aa76c966-0738-4109-8c65-a0ea5c1bc898"
$resourceGroupName="rg-networkservices"
$zoneName="thepowercoders.com"

# CHANGE INFORMATION
$recordType="CNAME"
$relativeRecordSetName=$RecordName
if($DeleteRecord){
  $NewBody=""
  $Method="DELETE"
}else{
  $Method="PUT"
  $Newbody = "{`"properties`": {`"TTL`": $TTL,`"CNAMERecord`": {`"cname`": `"$CName`"}}}"
}

$uriPath="https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Network/dnsZones/"
$resourcePath = "$zoneName/$recordType/$relativeRecordSetName`?api-version=2018-05-01"
$putUri= $uriPath + $resourcePath
$apiCall=Invoke-RestMethod -Method "$Method" -Uri "$putUri" -ContentType "application/json" -Body "$Newbody" -Headers @{Authorization = "Bearer $token" } -StatusCodeVariable StatusCode
#if($apiCall.properties.provisioningState -eq "Succeeded"){
#  Switch($StatusCode) {
#   200 {$returnCode="OK"}
#    201 {$returnCode="Created"}
#  }
#}elseif($StatusCode -eq 200 -And $Method -eq "DELETE"){$returnCode="OK"}
#elseif($StatusCode -eq 204){$returnCode="NotModified"}
#else{$returnCode="NotAcceptable"}
#
#$body = $apiCall

# Associate values to output bindings by calling 'Push-OutputBinding'.
#Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
#    StatusCode = [HttpStatusCode]::$returnCode
#    Body = $apiCall
#})
