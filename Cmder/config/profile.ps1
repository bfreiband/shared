# Init Script for PowerShell
# Created as part of Lori's cmder fork

# !!! THIS FILE IS OVERWRITTEN WHEN CMDER IS UPDATED
# !!! Use "%CMDER_ROOT%\config\user-profile.ps1" to add your own startup commands

# We do this for Powershell as Admin Sessions because CMDER_ROOT is not beng set.
if (! $ENV:CMDER_ROOT ) {
    $ENV:CMDER_ROOT = resolve-path( $ENV:ConEmuDir + "\..\.." )
}

# Remove trailing '\'
$ENV:CMDER_ROOT = (($ENV:CMDER_ROOT).trimend("\"))

# Compatibility with PS major versions <= 2
if(!$PSScriptRoot) {
    $PSScriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
}

# Add Cmder modules directory to the autoload path.
$CmderModulePath = Join-path $PSScriptRoot "psmodules/"

if( -not $env:PSModulePath.Contains($CmderModulePath) ){
    $env:PSModulePath = $env:PSModulePath.Insert(0, "$CmderModulePath;")
}

# Move to the wanted location
# This is either a env variable set by the user or the result of
# cmder.exe setting this variable due to a commandline argument or a "cmder here"
if ( $ENV:CMDER_START ) {
    Set-Location -Path "$ENV:CMDER_START"
}

# Drop *.ps1 files into "$ENV:CMDER_ROOT\config\profile.d"
# to source them at startup.
if (-not (test-path "$ENV:CMDER_ROOT\config\profile.d")) {
  mkdir "$ENV:CMDER_ROOT\config\profile.d"
}

pushd $ENV:CMDER_ROOT\config\profile.d
foreach ($x in ls *.ps1) {
  # write-host write-host Sourcing $x
  . $x
}
popd

$CmderUserProfilePath = Join-Path $env:CMDER_ROOT "config\user-profile.ps1"
if(Test-Path $CmderUserProfilePath) {
    # Create this file and place your own command in there.
    . "$CmderUserProfilePath"
} else {
    Write-Host "Creating user startup file: $CmderUserProfilePath"
    "# Use this file to run your own startup commands" | Out-File $CmderUserProfilePath
}
