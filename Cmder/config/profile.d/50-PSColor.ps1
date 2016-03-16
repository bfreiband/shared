Ensure-Module PSColor

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
