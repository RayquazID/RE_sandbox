function InitSetup {
    param (
    )
    $BasePath = "C:\Setup"
    Set-Location $BasePath
}
function DownloadProcMon {
    param (
    )
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
    $urlWireShark = "https://1.eu.dl.wireshark.org/win64/Wireshark-win64-3.4.8.exe"
    $FileName = "Wireshark-win64-3.4.8.exe"
    if ( -Not (Test-Path "$BasePath/Installer/Wireshark/$FileName")) {
        Invoke-WebRequest -Uri $urlWireShark -OutFile "$BasePath/Installer/Wireshark/$FileName"
        Remove-Item $FileName
    }
    else {
        return
    }
}
function DownloadMozilla {
    param (
    )
    #$urlMozilla = "https://www.mozilla.org/de/firefox/download/thanks/"
    $urlMozilla = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/91.0.2/win64/de/Firefox%20Setup%2091.0.2.msi"
    $FileName = "Firefox Setup 91.0.2.msi"
    if ( -Not (Test-Path "$BasePath/Installer/Mozilla/$FileName")) {
        Invoke-WebRequest -Uri $urlMozilla -OutFile "$BasePath/Installer/Mozilla/$FileName"
        Remove-Item $FileName
    }
    else {
        return
    }
}
function DownloadBurp {
    param (
    )
    $urlProcMon = ""
    $FileName = ""
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
function InstallPackages {
    param (
    ) 
}

DownloadProcMon