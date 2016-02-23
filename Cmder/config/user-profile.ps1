[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$MSYS64_BIN = "C:\Dev\msys64\usr\bin"

Import-Module PSReadLine

Set-PSReadlineOption -EditMode Emacs

Remove-Item alias:ls
# Work in progress
function ls { iex "${MSYS64_BIN}\ls -G --group-directories-first --color=auto -I NTUSER.DAT\* -I ntuser.\* -I desktop.ini ${args}" }

$Env:LANG = "en_US.UTF-8"
$Env:LC_ALL = "en_US.UTF-8"
$Env:LANGUAGE = "en_US.UTF-8"
$Env:MSYS = "winsymlinks:nativestrict"
$Env:TERM = "xterm"

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
