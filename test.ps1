#Set-ExecutionPolicy Bypass
$profilepath = "C:\Users\WDAGUtilityAccount\AppData\Roaming\Mozilla\Firefox\Profiles"
cd $profilepath
$profiles = Get-ChildItem -Path $profilepath -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName
#Write-Host $profiles
#$profiles.GetType().Name
foreach ($i in $profiles) {
    
    if ($i.FullName -match "\-release$") {
        $releaseProfile = $i.FullName
    } 

}