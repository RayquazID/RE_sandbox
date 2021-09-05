$Logfile = "C:/Setup/Logs/new_log.log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}
function InitSetup {
    param (
    )
    LogWrite("Start init setup")
    $BasePath = "C:/Setup"
    
    New-Item -Path "$BasePath" -Type Directory

    Set-Location $BasePath

    New-Item -Path "./Installer/" -Type Directory
    New-Item -Path "./Tools/" -Type Directory
    
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
function ConfigureBookmarks {
    param (
    )
    LogWrite("Start configure bookmarks")
    LogWrite("now firefox should start")
    Start-Process -FilePath "C:\Program Files\Mozilla Firefox\firefox.exe"
    LogWrite("now firefox should be started")
    New-Item –Path "HKCU:\Software\Policies\" –Name Mozilla
    New-Item –Path "HKCU:\Software\Policies\Mozilla\" –Name Firefox
    New-Item –Path "HKCU:\Software\Policies\Mozilla\Firefox\" –Name Bookmarks
    New-Item –Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" –Name 1
    New-Item –Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" –Name 2
    New-Item –Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" –Name 3
    New-Item –Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\" –Name 4

    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox" -Name DisplayBookmarksToolbar -Value "0x1"

    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\1\" -Name Title -Value "Shodan"
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\1\" -Name URL -Value "https://shodan.io"
    
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\2\" -Name Title -Value "dnsdumpster"
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\2\" -Name URL -Value "https://dnsdumpster.com"
    
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\3\" -Name Title -Value "gerynoise"
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\3\" -Name URL -Value "https://graynoise.io"
        
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\4\" -Name Title -Value "virustotal"
    Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Bookmarks\4\" -Name URL -Value "https://www.virustotal.com/gui/home/upload"

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