$GitFound = $false
try {
  # Check if git is on PATH, i.e. Git already installed on system
  Get-command git -ErrorAction Stop >$null
  $GitFound = $true
} 
catch {
  if (Test-Path $($Env:CMDER_ROOT + "\vendor\git")) {
    $env:Path += $(";" + $env:CMDER_ROOT + "\vendor\git\cmd")
    $GitFound = $true
  }
}

if ($GitFound) {
  Ensure-Module "posh-git"

  function CheckGit($Path) {
    if (Test-Path -Path (Join-Path $Path '.git') ) {
      Write-VcsStatus
      return
    }
    $SplitPath = split-path $path
    if ($SplitPath) {
      checkGit($SplitPath)
    }
  }
  
  # Load special features come from posh-git
  Start-SshAgent -Quiet
}

