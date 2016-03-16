function global:prompt {
  $realLASTEXITCODE = $LASTEXITCODE
  $Host.UI.RawUI.ForegroundColor = "Gray"
  Write-Host "( " -NoNewLine
  Write-Host $([Environment]::UserName) $([Environment]::UserDomainName) -Separator "@" -NoNewLine
  Write-Host " " -NoNewLine
  Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Blue
  if ($GitFound) {
    CheckGit($pwd.ProviderPath)
  }
  Write-Host " )" -NoNewLine
  $global:LASTEXITCODE = $realLASTEXITCODE
  Write-Host "`n$" -NoNewLine
  return " "
}
