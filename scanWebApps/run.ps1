# Input bindings are passed in via param block.
param($Timer, $poolDataFile, $stateTable)

# update table using Cosmos Table API as binding does not allow updates
function updateStateTable($webApp,$state) {
    if($currentState -eq $state){
        Write-Debug "[updateStateTable] webapp: $webapp, state unchanged since last probe"
    }else{
        $ctx=New-AzStorageContext -StorageAccountName "rgcloudnativeappsa03a" -StorageAccountKey "1/a5IlMpl7Hc5vnXtPTzr6Hnu5zrdV32aIDX+j3I6OjozzqoqTx08mFR8WO6QmRzRWghOV5hhQDO+AStziC2/g=="
        #$ctx=New-AzStorageContext -StorageAccountName "rgcloudnativeappsa03a" -UseConnectedAccount
        $cloudTable=(Get-AzStorageTable -Name stateTable -Context $ctx).CloudTable
        [string]$filter = [Microsoft.Azure.Cosmos.Table.TableQuery]::GenerateFilterCondition("RowKey",[Microsoft.Azure.Cosmos.Table.QueryComparisons]::Equal,"$webApp")
        $appState = Get-AzTableRow -table $cloudTable -customFilter $filter
        if($appState){
            $appState.status = $state
            $appState | Update-AzTableRow -table $cloudTable
            Write-Debug "[updateStateTable] updated state table for app: $webApp"
        }else{
            Add-AzTableRow -table $cloudTable -partitionKey "" `
            -rowKey ("$webapp") -property @{"status"=$state}
            Write-Debug "[updateStateTable] added new entry to state table for app: $webApp"
        }
        Invoke-RestMethod -Method "GET" -uri "https://gslbfunctions.azurewebsites.net/api/updateFqdnBestPath?code=j_60Osq5R7rvTzY8g9aYt5XAngy7GRSpdz5GhoFqcRupAzFuPMhvEQ=="
    }
}

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Warning "[scanWebApps] timer is running late!"
}

Write-Debug "total health checks required: $($poolDataFile.Count)"
$n=0
for($n=0;$n -lt $($poolDataFile.Count);$n++){
    $webApp=$($poolDataFile.RowKey[$n])
    $stateEntry = $stateTable | Where-Object{ $_.RowKey -eq "$webApp" }
    $currentState = $stateEntry.status
    if($currentState -ne 0 -and $currentState -ne 1){$currentState='2'}
    Write-Debug "[scanWebApps] Starting health probe for web app: $webApp"
    $healthCheckUrl="https://" + $($poolDataFile.URL[$n]) + "`/" + $($poolDataFile.endpoint[$n])
    $rcv=$($poolDataFile.receiveString[$n])
    Try {
        $health=Invoke-RestMethod -Method "GET" -uri "$healthCheckUrl" -SkipHttpErrorCheck -StatusCodeVariable StatusCode
    }
    Catch {
        if($_.ErrorDetails.Message) {
            Write-Debug "[scanWebApps] failed to reach app: $webApp, reason: $($_.ErrorDetails.Message)"
        }else{
            Write-Debug "[scanWebApps] failed to reach app: $webApp, reason: an exception has occurred."
        }
    }
    Switch($StatusCode){
        200 {
            Switch -regex ($health){
                "$rcv" {
                    Write-Debug "[scanWebApps] Monitor reports webapp: $webApp as UP,HEALTHY - valid response received"
                    Write-Host "[METRICS-WEBAPPS-STATUS]$webApp=HEALTHY"
                    #$metricLog=$metricLog + ",$webApp=HEALTHY"
                    updateStateTable $webapp 1
                }
                default {
                    Write-Debug "[scanWebApps] Monitor reports webapp: $webApp as UP,UNHEALTHY - invalid response received"
                    Write-Host "[METRICS-WEBAPPS-STATUS]$webApp=UNHEALTHY"
                    #$metricLog=$metricLog + ",$webApp=UNHEALTHY"
                    updateStateTable $webApp 0
                }
            }
        }
        403 {
            Write-Debug "[scanWebApps] Monitor reports webapp: $webApp as DOWN,DISABLED - request forbidden (403)"
            Write-Host "[METRICS-WEBAPPS-STATUS]$webApp=DISABLED"
            #$metricLog=$metricLog + ",$webApp=DISABLED"
            updateStateTable $webApp 0
        }
        404 {
            Write-Debug "[scanWebApps] Monitor reports webapp: $webApp as DOWN,NOTFOUND - no response (404)"
            Write-Host "[METRICS-WEBAPPS-STATUS]$webApp=NOTFOUND"
            #$metricLog=$metricLog + ",$webApp=NOTFOUND"
            updateStateTable $webApp 0
        }
        default {
            Write-Debug "[scanWebApps] Monitor reports webapp: $webApp as DOWN,UNKNOWN - unknown response $StatusCode"
            Write-Host "[METRICS-WEBAPPS-STATUS]$webApp=UNKNOWN"
            #$metricLog=$metricLog + ",$webApp=UNKNOWN"
            updateStateTable $webApp 0
        }
    }
}

# Write an information log with the current time.
Write-Host "[METRICS-WEBAPPS-COUNT]$($poolDataFile.Count)"
Write-Debug "[scanWebApps] completed health checks at: $currentUTCtime"
