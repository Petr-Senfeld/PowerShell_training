$HostNames_path = "path"                                            ### target path to .csv
$target_file_path = "path"                                          ### target path to file
$report_name = Get-Date -UFormat "%Y-%m-%d-%A-%Hh-%Mm"                                  
$report_path = "path"                                               ### target path to report
$report_path2 = "path"                                              ### target Failed path to report

$hostNames = Import-Csv -Path $hostNames_path

Write-Host "The copying just started..."

ForEach ($item in $hostNames) {

    $hostName = $item.("pc_name")
    $userName = $item.("user_name")
    
    $testPath = "\\$hostname\C$\app\client\product\12.2.0\client_1\network\admin"        ###
    $testPath_2 = "\\$hostname\C$\app\client\product\12.2.0-x64\client_1\network\admin"  ###

    if ( $(Try { Test-Path $testPath.trim() } Catch {$false}) ) {

        Write-host "$hostName $userName Path OK" -ForegroundColor Green
        Copy-Item -Path $target_file_path  -Destination "$testPath"
        Add-Content -Path $report_path -Value "$userName $hostName Copy - OK"
    }
    elseif ( $(Try { Test-Path $testPath_2.trim() } Catch {$false}) ) {

        Write-host "$hostName $userName Path OK" -ForegroundColor Green
        Copy-Item -Path $target_file_path  -Destination "$testPath_2"
        Add-Content -Path $report_path -Value "$userName $hostName Copy - OK"
    }
    Else {
        Write-host "$hostName $userName Path not found" -ForegroundColor Red
        Add-Content -Path $report_path2 -Value "$userName $hostName Copy - Fail"
    }
   
    }

    Write-Host "Script COPY-ITEM has done it's work" -ForegroundColor Yellow -BackgroundColor DarkGreen
