@echo off
REM Run the PowerShell password reset helper as Administrator

set SCRIPT_DIR=%~dp0
set PS1=%SCRIPT_DIR%reset-postgres-password.ps1

if not exist "%PS1%" (
  echo ERROR: %PS1% not found.
  pause
  exit /b 1
)

echo This will temporarily relax local authentication to reset the 'postgres' password.
echo You MUST run this as Administrator.
echo.
set /p NEWPASS=Enter NEW password for 'postgres': 

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%" -NewPassword "%NEWPASS%"

pause
