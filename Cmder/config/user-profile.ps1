[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Import-Module PSReadLine
Import-Module PowerLS
Import-Module PSColor

Set-PSReadlineOption -EditMode Emacs

Set-Alias -Name ls -Value PowerLS -Option AllScope

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
        Directory  = @{ Color = 'DarkCyan'}
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
