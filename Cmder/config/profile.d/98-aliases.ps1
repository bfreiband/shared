
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
Add-Alias more 'less'
