[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$env:PSModulePath = "$Env:CMDER_ROOT\config\modules;$Env:PSModulePath"

Import-Module PsGet

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

Ensure-Module-By-Url Posh-Alias https://github.com/giggio/posh-alias/zipball/master

$Env:LANG = "en_US.UTF-8"
$Env:LC_ALL = "en_US.UTF-8"
$Env:LANGUAGE = "en_US.UTF-8"
$Env:MSYS = "winsymlinks:nativestrict"
$Env:TERM = "xterm"

# TODO: I *want* to set this to UTF-8, but it causes some Windows programs
# to crash. Setting this to 1252 to make the postgres client happy
chcp 1252 > $null

function which {
  (Get-Command ${args}).definition
}
