using namespace System.Net
# Input bindings are passed in via param block
param($Request, $fqdnDataFile, $poolDataFile, $bestAppTable, $stateTable)

function updateFqdnBestPath($changedPool,$newBestApp){
    for($n=0;$n -lt $fqdnDataFile.Count;$n++){
        $fqdn=$fqdnDataFile[0].RowKey
        $pool=$fqdnDataFile[0].pool
        if("$pool" -eq "$changedPool"){
            Write-Debug "[updateFqdnBestPath] pool change detected for fqdn: $fqdn"
            if($newBestApp -eq "NULL"){
                Write-Debug "[updateFqdnBestPath] Deleting DNS for fqdn: $fqdn - Reason: pool is DOWN"
                $qmsg = "{`"RecordName`": `"$fqdn`",`"CName`": `"null`",`"action`": `"delete`"}"
                Push-OutputBinding -Name outputQueueItem -Value $qmsg
            }else{
                Write-Debug "[updateFqdnBestPath] Updating DNS for fqdn: $fqdn - new best path: $newBestApp"
                $newCName=($poolDataFile | Where-Object RowKey -eq $newBestApp).URL
                $TTL=$fqdnDataFile[0].ttl
                Write-Debug "[updateFqdnBestPath] fqdn: $fqdn resolves to URL Path: $newCName"
                $qmsg = "{`"RecordName`": `"$fqdn`",`"CName`": `"$newCName`",`"action`": `"update`",`"TTL`": $TTL}"
                Push-OutputBinding -Name outputQueueItem -Value $qmsg
            }
            $gslbMetricLog=$gslbMetricLog + ",$fqdn=$newBestApp"
        }
    }
    Write-Host $gslbMetricLog
}

function updateBestAppTable($pool,$bestApp) {
    $ctx=New-AzStorageContext -StorageAccountName "rgcloudnativeappsa03a" -StorageAccountKey "1/a5IlMpl7Hc5vnXtPTzr6Hnu5zrdV32aIDX+j3I6OjozzqoqTx08mFR8WO6QmRzRWghOV5hhQDO+AStziC2/g=="
    #$ctx=New-AzStorageContext -StorageAccountName "rgcloudnativeappsa03a" -UseConnectedAccount
    $cloudTable=(Get-AzStorageTable -Name bestAppTable -Context $ctx).CloudTable
    [string]$filter = [Microsoft.Azure.Cosmos.Table.TableQuery]::GenerateFilterCondition("RowKey",[Microsoft.Azure.Cosmos.Table.QueryComparisons]::Equal,"$pool")
    $poolRow = Get-AzTableRow -table $cloudTable -customFilter $filter
    if($poolRow){
        $poolRow.bestApp = $bestApp
        $poolRow | Update-AzTableRow -table $cloudTable
        Write-Debug "[updateBestAppTable] updated bestApp table for pool: $pool"
    }else{
        Add-AzTableRow -table $cloudTable -partitionKey "" `
        -rowKey ("$pool") -property @{"bestApp"="$bestApp"}
        Write-Debug "[updateBestAppTable] added new entry to bestApp table for pool: $pool"
    }
}

function poolStatus($pool){
    $prefGP=999
    $pref="none"
    $poolEntry = $poolDataFile | Where-Object{ $_.pool -eq "$pool" }
    $poolMembers = $poolEntry.RowKey
    foreach($poolMember in $poolMembers){
      $memberData = $poolDataFile | Where-Object{ $_.RowKey -eq "$poolMember" }
      $stateEntry = $stateTable | Where-Object{ $_.RowKey -eq "$poolMember" }
      $memberState = $stateEntry.status
      if($memberState -eq 1 -and $memberData.globalPriority -lt $prefGP){
        $pref=$memberData.RowKey
        $prefGP=$memberData.globalPriority
      }
    }
    if($pref -eq "none"){
        Write-Debug "[poolStatus] Pool Status: DOWN - no members are available in pool: $pool"
        return "NULL"
    }else {
        Write-Debug "[poolStatus] Pool Status: UP - pool: $pool using member: $pref based on global priority"
        return "$pref"
    }
  }

function bestAppAlgorithm {
  foreach($pool in $poolDataFile.pool | Select-Object -Unique){
    $BestAppRow = $bestAppTable | Where-Object{ $_.RowKey -eq "$pool" }
    $previousBestApp = $BestAppRow.bestApp
    $currentBestApp=poolStatus "$pool"
    switch($currentBestApp){
      "$previousBestApp" {
        if($currentBestApp="NULL"){$currentBestApp="none"}
        Write-Debug "[bestAppAlgorithm] pool: $pool - best path unchanged: $currentBestApp"
        $poolMetricLog=$poolMetricLog + ",$pool=$currentBestApp"
        Break
      }
      "NULL" {
        Write-Debug "[bestAppAlgorithm] pool: $pool - no best path available"
        updateBestAppTable "$pool" "NULL"
        updateFqdnBestPath "$pool" "NULL"
        $poolMetricLog=$poolMetricLog + ",$pool=NULL"
        Break
      }
      default {
        Write-Debug "[bestAppAlgorithm] pool: $pool - new best path for pool: $currentBestApp"
        updateBestAppTable "$pool" "$currentBestApp"
        updateFqdnBestPath "$pool" "$currentBestApp"
        $poolMetricLog=$poolMetricLog + ",$pool=$currentBestApp"
      }
    }
  }
  Write-Host $poolMetricLog
}

$poolMetricLog="[METRICS-POOLS]"
$gslbMetricLog="[METRICS-FQDNS]"
bestAppAlgorithm





