While ($true)
{
    # Get the list of running Hyper-V VMs and their IP addresses
    $vmList = Get-VM | Where-Object { $_.State -eq 'Running' } | ForEach-Object {
        $vmName = $_.Name
        $vmIP = $_ | ForEach-Object {
            $vmId = $_.Id
            $ipConfig = (Get-VMNetworkAdapter -VMName $vmName).IPAddresses
            if ($ipConfig.Count -gt 0) {
                $ipConfig[0]
            }
            else{
                Write-Host $vmName "VM does not return its ip address. Look at README.md"
            }
        }
        if ($vmIP) {
            [PSCustomObject]@{
                Name = $vmName
                IP = $vmIP
            }
        }
    }

    # Write the information to the hosts file
    $hostsFilePath = "$env:SystemRoot\System32\drivers\etc\hosts"
    # Read the contents of the hosts file
    $hostsContent = Get-Content -Path $hostsFilePath

    # Filter out lines containing [HYPERV2HOSTS]
    $filteredContent = $hostsContent | Where-Object { $_ -notmatch '\[HYPERV2HOSTS\]' }
    # Find the index of the last non-empty line
    $lastNonEmptyLineIndex = ($filteredContent | Where-Object { $_ -match '\S' } | Measure-Object).Count - 1
    # Determine the content to keep
    $contentToKeep = $filteredContent[0..$lastNonEmptyLineIndex]

    # Write the filtered content back to the hosts file
    $contentToKeep | Set-Content -Path $hostsFilePath

    $currentTime = Get-Date -Format "MM/dd/yyyy HH:mm"
    $hostEntries = @($vmList | ForEach-Object {
        "$($_.IP)`t$($_.Name) # [HYPERV2HOSTS]`r`n"
    }
    ) -Join ''
    $hostEntries = "# [HYPERV2HOSTS] Updated at $currentTime`r`n" + $hostEntries

    Add-Content -Path $hostsFilePath -Value $hostEntries
    Write-Host "`r`nThis lines was added to hosts file:`r`n"$hostEntries
        
    Read-Host “Press ENTER to continue...”
}
