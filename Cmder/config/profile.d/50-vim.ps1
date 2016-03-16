
try {
  Get-Command vim -ErrorAction Stop >$null
  $VIM_BIN = (Get-Command vim).definition | Split-Path
} 
catch {
  if (Test-Path $($ENV:CMDER_ROOT + "\vendor\vim\vim74")) {
    $VIM_BIN = $($ENV:CMDER_ROOT + "\vendor\vim\vim74")
  }
}

if ($VIM_BIN) {
  function vim {
    iex "${VIM_BIN}\vim ${args}"
    Write-Output ""
  }

  Add-Alias vi 'vim'
  Add-Alias gvim "${VIM_BIN}\gvim"
  $Env:Editor = "vim"
}
