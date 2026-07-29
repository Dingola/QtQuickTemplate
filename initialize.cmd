@echo off
setlocal

REM Run the bootstrap script with a process-local execution policy override.
REM This does not change the machine-wide or user-wide PowerShell policy.
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0initialize.ps1" %*
set "INITIALIZE_EXIT_CODE=%ERRORLEVEL%"

if "%INITIALIZE_EXIT_CODE%"=="0" del /f /q "%~f0"

endlocal & exit /b %INITIALIZE_EXIT_CODE%
