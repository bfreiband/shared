Import-Module Get-ChildItemColored
$global:lscolor_dir = "Blue"

Ensure-Module Posh-Git
Ensure-Module PSReadLine
Ensure-Module TabExpansionPlusPlus
Ensure-Module Invoke-ElevatedCommand
Ensure-Module PsUrl

Remove-Item alias:gpv -Force
Ensure-Module-Installed Pscx
Import-Module Pscx -arg $Env:CMDER_ROOT\config\Pscx.UserPreferences.ps1

Ensure-Module-By-Url Posh-SSH https://github.com/darkoperator/Posh-SSH/zipball/master
