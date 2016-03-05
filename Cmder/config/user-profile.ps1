[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$env:PSModulePath = "$env:PSModulePath;$Env:CMDER_ROOT\config\modules"

#
# Modules
#
function Ensure-Module-Installed {
  if (-not (Get-Module -list $args[0])) {
    Install-Module $args[0] -DoNotImport
  }
}

function Ensure-Module-Installed-By-Url {
  if (-not (Get-Module -list $args[0])) {
    Install-Module -ModuleUrl $args[1] -DoNotImport
  }
}

function Ensure-Module {
  Ensure-Module-Installed $args[0]
  Import-Module $args[0]
}

function Ensure-Module-By-Url {
  Ensure-Module-Installed-By-Url $args[0] $args[1]
  Import-Module $args[0]
}

Import-Module Get-ChildItemColored

Ensure-Module Posh-Git
Ensure-Module PSReadLine
Ensure-Module PSColor
Ensure-Module TabExpansionPlusPlus
Ensure-Module Invoke-ElevatedCommand
Ensure-Module PsUrl

Remove-Item alias:gpv -Force
Ensure-Module-Installed Pscx
Import-Module Pscx -arg $Env:CMDER_ROOT\config\Pscx.UserPreferences.ps1

Ensure-Module-By-Url Posh-SSH https://github.com/darkoperator/Posh-SSH/zipball/master
Ensure-Module-By-Url Posh-Alias https://github.com/giggio/posh-alias/zipball/master

#
# Environment
# 

$Env:LANG = "en_US.UTF-8"
$Env:LC_ALL = "en_US.UTF-8"
$Env:LANGUAGE = "en_US.UTF-8"
$Env:MSYS = "winsymlinks:nativestrict"
$Env:TERM = "xterm"
$Env:GO15VENDOREXPERIMENT = "1"
$Env:GOPATH = "C:\Users\Lori\Projects\gocode"
$Env:Path = "$Env:GOPATH\bin;$Env:Path"

$MSYS64_BIN = "C:\Dev\msys64\usr\bin"
$VIM_BIN = "C:\Dev\vim\vim74"

#
# Aliases
#
Remove-Item alias:dir
Remove-Item alias:ls
Remove-Item alias:ln
Remove-Item alias:wget
Add-Alias alias 'Add-Alias'
Add-Alias ls 'Get-ChildItemColored'
Add-Alias lsa 'Get-ChildItemColored -Force'
Add-Alias dir 'Get-ChildItem -Exclude ".*"'
Add-Alias dira 'Get-ChildItem'
Add-Alias ln 'New-Symlink'
Add-Alias df 'get-psdrive -PSProvider FileSystem'
Add-Alias sudo 'Invoke-ElevatedCommand'
Add-Alias wget 'Get-WebContent'
Add-Alias New-File 'New-Item -Type File -Path'
Add-Alias update-core "${MSYS64_BIN}\bash ${MSYS64_BIN}\update-core"


#
# Custom Functions
#

function vim {
  iex "${VIM_BIN}\vim ${args}"
  Write-Output ""
}

#
# Settings
# 
Set-PSReadlineOption -EditMode Emacs -HistoryNoDuplicates

$global:lscolor_dir = "Blue"

function global:prompt {
  $realLASTEXITCODE = $LASTEXITCODE
  $Host.UI.RawUI.ForegroundColor = "Gray"
  Write-Host "( " -NoNewLine
  Write-Host $([Environment]::UserName) $([Environment]::UserDomainName) -Separator "@" -NoNewLine
  Write-Host " " -NoNewLine
  Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Blue
  if($gitStatus){
      checkGit($pwd.ProviderPath)
  }
  Write-Host " )" -NoNewLine
  $global:LASTEXITCODE = $realLASTEXITCODE
  Write-Host "`n$" -NoNewLine
  return " "
}

$global:PSColor = @{
  File = @{
    Default    = @{ Color = 'Gray' }
    Directory  = @{ Color = 'Blue'}
    # Hidden and backup
    Hidden     = @{ Color = 'DarkGray'; Pattern = '(^(~|\.)|(\.bak|~)$)' }
    Code       = @{ Color = 'Magenta'; Pattern = '\.(jpg|jpeg|gif|png|tif|bmp|svg|xcf|psd)$' }
    Executable = @{ Color = 'Green'; Pattern = '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|fsx|msi|sh)$' }
    Text       = @{ Color = 'DarkYellow'; Pattern = '^$' }
    Compressed = @{ Color = 'Red'; Pattern = '\.(zip|tar|gz|rar|7z|bz2|tgz|tcz)$' }
  }
  Service = @{
    Default = @{ Color = 'Gray' }
    Running = @{ Color = 'DarkGreen' }
    Stopped = @{ Color = 'DarkRed' }
  }
  Match = @{
    Default    = @{ Color = 'Gray' }
    Path       = @{ Color = 'DarkCyan'}
   LineNumber = @{ Color = 'DarkYellow' }
    Line       = @{ Color = 'Gray' }
  }
}
