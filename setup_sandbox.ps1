$Logfile = "C:/Setup/Logs/new_log.log"


Function LogWrite
{
    Param ([string]$logstring)
    $time = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
    Add-content -Path $Logfile -value "Time: $time Message: $logstring"
}
function InitSetup {
    param (
    )
    
    $BasePath = "C:/Setup"
    
    New-Item -Path "$BasePath" -Type Directory

    Set-Location $BasePath
    New-Item -Path "./Logs" -Type Directory
    New-Item -Path "./Installer/" -Type Directory
    New-Item -Path "./Tools/" -Type Directory
    $initRegUrl = "https://raw.githubusercontent.com/RayquazID/RE_sandbox/main/init.reg"
    Invoke-WebRequest -Uri $initRegUrl -OutFile "./init.reg"
    importRegistry("./init.reg")
    
    LogWrite("Init Setup done")
}
function DownloadProcMon {
    param (
    )
    New-Item -Path "./Tools/ProcMon" -Type Directory
    $urlProcMon = "https://download.sysinternals.com/files/ProcessMonitor.zip"
    $FileName = "ProcessMonitor.zip"
    if ( -Not (Test-Path $FileName)) {
        Invoke-WebRequest -Uri $urlProcMon -OutFile $FileName
        Expand-Archive $FileName -DestinationPath "./Tools/ProcMon/" -Force
        Remove-Item $FileName
    }
    Start-Process -FilePath "./Installer/Wireshark/$FileName"
}
function DownloadWireshark {
    param (
    )
    New-Item -Path "./Installer/Wireshark" -Type Directory
    $urlWireShark = "https://1.eu.dl.wireshark.org/win64/Wireshark-win64-3.4.8.exe"
    $FileName = "Wireshark-win64-3.4.8.exe"
    if ( -Not (Test-Path "./Installer/Wireshark/$FileName")) {
        Invoke-WebRequest -Uri $urlWireShark -OutFile "./Installer/Wireshark/$FileName"
    }
    Start-Process -FilePath "./Installer/Wireshark/$FileName"
}
function DownloadMozilla {
    param (
    )
    LogWrite("Start Downloading firefox setup download")
    New-Item -Path "./Installer/Mozilla" -Type Directory
    $urlMozilla = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/91.0.2/win64/de/Firefox%20Setup%2091.0.2.msi"
    $FileName = "Firefox-Setup-91.0.2.msi"
    if ( -Not (Test-Path "./Installer/Mozilla/$FileName")) {
        Invoke-WebRequest -Uri $urlMozilla -OutFile "./Installer/Mozilla/$FileName"
    }
    LogWrite("Start firefox setup")
    Start-Process -FilePath "./Installer/Mozilla/$FileName"
}
function DownloadBurp {
    param (
    )
    New-Item -Path "./Installer/Burp" -Type Directory
    $urlBurp = "https://portswigger.net/burp/releases/download?product=community&version=2021.8.2&type=WindowsX64"
    $FileName = "burpsuite_community_windows-x64_v2021_8_2.exe"
    if ( -Not (Test-Path "./Installer/Mozilla/$FileName")) {
        Invoke-WebRequest -Uri $urlBurp -OutFile "./Installer/Burp/$FileName"
    }
    Start-Process -FilePath "./Installer/Burp/$FileName"
}
function DownloadVSCode {
    param (
    )
    New-Item -Path "./Installer/vscode" -Type Directory
    $urlVSCode = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
    $FileName = "VSCodeSystemSetup.exe"
    if ( -Not (Test-Path "./Installer/vscode/$FileName")) {
        Invoke-WebRequest -Uri $urlVSCode -OutFile "./Installer/vscode/$FileName"
    }
    Start-Process -FilePath "./Installer/vscode/$FileName"
}
function importRegistry {
    param (
        [String]$regPath
    )

    #Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"C:\setup\bookmarks.reg`"" -Wait -passthru
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import $regPath" -Wait -passthru
}
function ConfigureBookmarks {
    param (
    )
    LogWrite("wait for firefox to finish setup")
    Write-Host "Wait a few secs"
    Start-Sleep -s 10

    LogWrite("Start configure bookmarks")
    $toolbar = "{`"policies`": {`"DisplayBookmarksToolbar`": true}}"
    New-Item -Path "C:\Program Files\Mozilla Firefox\distribution" -Type Directory
    New-Item -Path "C:\Program Files\Mozilla Firefox\distribution\policies.json" -Type File
    Add-Content -Path "C:\Program Files\Mozilla Firefox\distribution\policies.json" -Value $toolbar
    
    LogWrite("now firefox should start")
    Start-Process -FilePath "C:\Program Files\Mozilla Firefox\firefox.exe"
    
    Start-Sleep -s 5
    
    LogWrite("now firefox should be started")
    Stop-Process -Name "firefox"
    LogWrite("now firefox should be stopped")
    
    $BookmarksRegUrl = "https://raw.githubusercontent.com/RayquazID/RE_sandbox/main/bookmarks.reg"
    Invoke-WebRequest -Uri $BookmarksRegUrl -OutFile "./bookmarks.reg"

    # import reg
    importRegistry("./bookmarks.reg")


    
    
    #New-Item ???Path "HKCU:\Software\Policies\" ???Name Mozilla
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\" ???Name Firefox
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\Firefox\" ???Name Bookmarks
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" ???Name 1
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" ???Name 2
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" ???Name 3
    #New-Item ???Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" ???Name 4
    LogWrite("now bookmark reg key should be set")

    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox" -Name DisplayBookmarksToolbar -Value "0x1"
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\1\" -Name Title -Value "Shodan"
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\1\" -Name URL -Value "https://shodan.io"
    
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\2\" -Name Title -Value "dnsdumpster"
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\2\" -Name URL -Value "https://dnsdumpster.com"
    
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\3\" -Name Title -Value "gerynoise"
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\3\" -Name URL -Value "https://graynoise.io"
        
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\4\" -Name Title -Value "virustotal"
    #Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\4\" -Name URL -Value "https://www.virustotal.com/gui/home/upload"
    
    LogWrite("now bookmarks should be set")
    return

}
function DownloadAll {
    param (
    )
    #DownloadProcMon
    #DownloadWireshark
    DownloadMozilla
    #DownloadBurp
    #DownloadVSCode
    ConfigureBookmarks
    return
}
function Configure {
    param (
    )
    ConfigureBookmarks
    return
}
function InstallPackages {
    param (
    ) 
}

InitSetup
DownloadAll
#Configure