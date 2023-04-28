$psdir="$env:USERPROFILE\Documents\Powershell"
Write-Host ("Loading PS Profiles from {0}\conf.d" -f $psdir) -ForegroundColor DarkCyan
Get-ChildItem $psdir\conf.d | where Extension -eq ".ps1" | %{.$_.FullName}