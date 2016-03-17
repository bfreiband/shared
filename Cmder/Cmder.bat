@echo off
SET CMDER_ROOT=%~dp0

:: Remove trailing '\'
@if "%CMDER_ROOT:~-1%" == "\" SET CMDER_ROOT=%CMDER_ROOT:~0,-1%

if exist "%~1" (
    start %~dp0/vendor/conemu-maximus5/ConEmu64.exe /Icon "%CMDER_ROOT%\icons\cmder.ico" /Title PowerShell 
) else (
    start %~dp0/vendor/conemu-maximus5/ConEmu64.exe /Icon "%CMDER_ROOT%\icons\cmder.ico" /Title PowerShell 
)
