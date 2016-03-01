[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

#
# Modules
#
function Ensure-Module {
  if (-not (get-module -list $args[0])) {
    Install-Module $args[0]
  }

  Import-Module $args[0]
}

Ensure-Module PSReadLine
Ensure-Module TabExpansionPlusPlus
Ensure-Module posh-alias
Ensure-Module PSColor

Set-PSReadlineOption -EditMode Emacs -HistoryNoDuplicates

#
# Environment
#

$Env:LANG = "en_US.UTF-8"
$Env:LC_ALL = "en_US.UTF-8"
$Env:LANGUAGE = "en_US.UTF-8"
$Env:MSYS = "winsymlinks:nativestrict"
$Env:TERM = "xterm"

$MSYS64_BIN = "C:\Dev\msys64\usr\bin"
$VIM_BIN = "C:\Dev\vim\vim74"


#
# General config stuff
#
Add-Alias alias "Add-Alias"

Remove-Item alias:ls
Add-Alias ls "${MSYS64_BIN}\ls -G --group-directories-first --color=auto -I NTUSER.DAT\* -I ntuser.\* -I desktop.ini"
Add-Alias update-core "${MSYS64_BIN}\bash ${MSYS64_BIN}\update-core"
Add-Alias alias "Add-Alias"

function vim {
  iex "${VIM_BIN}\vim ${args}"
  Write-Output ""
}

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
    Write-Host "`nλ" -NoNewLine
    return " "
}

$global:PSColor = @{
    File = @{
        Default    = @{ Color = 'Gray' }
        Directory  = @{ Color = 'Blue'}
        Hidden     = @{ Color = 'DarkGray'; Pattern = '^\.' } 
        Code       = @{ Color = 'Magenta'; Pattern = '\.(java|c|cpp|cs|js|css|html)$' }
        Executable = @{ Color = 'DarkRed'; Pattern = '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg)$' }
        Text       = @{ Color = 'DarkYellow'; Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown)$' }
        Compressed = @{ Color = 'DarkGreen'; Pattern = '\.(zip|tar|gz|rar|jar|war)$' }
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
