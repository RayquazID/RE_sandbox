
#Requires -RunAsAdministrator

function CheckDeps {
    param (
    )
    $MajorVersion = [environment]::OSVersion.Version.Major
    $BuildVersion = [environment]::OSVersion.Version.Build

    Write-Host "Win $MajorVersion Build Version $BuildVersion" -ForegroundColor Magenta
    
    if ($MajorVersion -ge 10){
        Write-Host "Major Version is ok" -ForegroundColor Magenta
        if ($BuildVersion -ge 18305){
            Write-Host "Build Version is ok" -ForegroundColor Magenta
            return $true
        }
        else{
            return $false
        }
    }
    else{
        return $false
    }
}
function CheckFeature {
    param (
    )
    $sandboxfeature = get-windowsoptionalfeature -online | Where-Object -Property FeatureName -eq Containers-DisposableClientVM
    $sandboxfeatureState = $sandboxfeature.State

    if ($sandboxfeatureState -eq "Disabled" -or $sandboxfeatureState -eq "Enabled") {
        Write-Host "Sandbox Feature is $sandboxfeatureState" -ForegroundColor Magenta
    }
    else {
        Write-Host "Sryly you are using a home license?" -ForegroundColor Magenta
        return $false
    }
    return $true
}

if (CheckDeps -eq $true) {
    if (CheckFeature -eq $true) {
        Write-Host "Sandbox Feature wird nun aktiviert" -ForegroundColor Magenta
        Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All
    }
}