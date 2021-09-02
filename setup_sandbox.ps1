function InitSetup {
    param (
    )
    $BasePath = "C:/Setup"
    
    New-Item -Path "$BasePath" -Type Directory

    Set-Location $BasePath

    New-Item -Path "./Installer/" -Type Directory
    New-Item -Path "./Tools/" -Type Directory
    
}
function DownloadProcMon {
    param (
    )
    New-Item -Path "$BasePath/Tools/ProcMon" -Type Directory
    $urlProcMon = "https://download.sysinternals.com/files/ProcessMonitor.zip"
    $FileName = "ProcessMonitor.zip"
    if ( -Not (Test-Path $FileName)) {
        Invoke-WebRequest -Uri $urlProcMon -OutFile $FileName
        Expand-Archive $FileName -DestinationPath "$BasePath/Tools/ProcMon/" -Force
        Remove-Item $FileName
    }
    else {
        Expand-Archive $FileName -DestinationPath "$BasePath/Tools/ProcMon/" -Force
        Remove-Item $FileName
    }
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
}
function DownloadMozilla {
    param (
    )
    New-Item -Path "./Installer/Mozilla" -Type Directory
    $urlMozilla = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/91.0.2/win64/de/Firefox%20Setup%2091.0.2.msi"
    $FileName = "Firefox Setup 91.0.2.msi"
    if ( -Not (Test-Path "./Installer/Mozilla/$FileName")) {
        Invoke-WebRequest -Uri $urlMozilla -OutFile "./Installer/Mozilla/$FileName"
    }
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
}
function DownloadVSCode {
    param (
    )
    New-Item -Path "./Installer/vscode" -Type Directory
    $urlVSCode = "https://az764295.vo.msecnd.net/stable/3866c3553be8b268c8a7f8c0482c0c0177aa8bfa/VSCodeUserSetup-x64-1.59.1.exe"
    $FileName = "VSCodeUserSetup-x64-1.59.1.exe"
    if ( -Not (Test-Path "./Installer/vscode/$FileName")) {
        Invoke-WebRequest -Uri $urlVSCode -OutFile "./Installer/vscode/$FileName"
    }
}
function InstallPackages {
    param (
    ) 
}

InitSetup
DownloadProcMon
DownloadWireshark
DownloadMozilla
DownloadBurp
DownloadVSCode