[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

#
# Modules
#
function Find-And-Install-Module {
  if (-not (Get-Module -list $args[0])) {
    Find-Module $args[0] | Install-Module
  }
}
function Ensure-Module {
  Find-And-Install-Module $args[0]

  Import-Module $args[0]
}

function Ensure-Module-By-Url {
  if (-not (Get-Module -list $args[0])) {
    Install-Module -ModuleUrl $args[1]
  }

  Import-Module $args[0]
}

Ensure-Module PSReadLine
Ensure-Module TabExpansionPlusPlus
Ensure-Module posh-alias
Ensure-Module PSColor
Ensure-Module Posh-SSH
Ensure-Module Invoke-ElevatedCommand

Ensure-Module-By-Url Get-ChildItemColored https://gist.githubusercontent.com/la11111/3922035/raw/20ed19adbd7e0fbc0e69236c4810aa7e414b672a/get-ChildItemColored.psm1

Find-And-Install-Module Pscx
Import-Module Pscx -arg $Env:CMDER_ROOT\config\Pscx.UserPreferences.ps1

Set-PSReadlineOption -EditMode Emacs -HistoryNoDuplicates

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
Add-Alias alias 'Add-Alias'
Add-Alias ls 'Get-ChildItemColored'
Add-Alias lsa 'Get-ChildItemColored -Force'
Add-Alias dir 'Get-ChildItem -Exclude ".*"'
Add-Alias dira 'Get-ChildItem'
Add-Alias ln 'New-Symlink'
Add-Alias df 'get-psdrive -PSProvider FileSystem'
Add-Alias sudo 'Invoke-ElevatedCommand'
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
