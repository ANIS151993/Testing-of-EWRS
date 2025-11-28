@echo off
REM ============================================================
REM PostgreSQL Installation Helper for Windows
REM This script helps download and install PostgreSQL
REM ============================================================

echo.
echo ========================================
echo PostgreSQL Installation Helper
echo ========================================
echo.

REM Check if PostgreSQL is already installed
where psql >nul 2>nul
if %errorlevel% equ 0 (
    echo PostgreSQL is already installed!
    psql --version
    echo.
    echo PostgreSQL location:
    where psql
    echo.
    set /p CONTINUE="Do you want to continue with database setup? (Y/N): "
    if /i "%CONTINUE%"=="Y" (
        cd "%~dp0"
        call setup-database.bat
    )
    exit /b 0
)

echo PostgreSQL is NOT installed on your system.
echo.
echo To install PostgreSQL:
echo.
echo 1. Visit: https://www.postgresql.org/download/windows/
echo 2. Download PostgreSQL 16 (recommended)
echo 3. Run the installer
echo 4. During installation:
echo    - Set a strong password for the 'postgres' user
echo    - Use default port: 5432
echo    - Install all components (Server, pgAdmin, Command Line Tools)
echo 5. After installation, add to PATH:
echo    C:\Program Files\PostgreSQL\16\bin
echo 6. Restart PowerShell/Command Prompt
echo 7. Run this script again
echo.
echo.

set /p DOWNLOAD="Open PostgreSQL download page in browser? (Y/N): "
if /i "%DOWNLOAD%"=="Y" (
    start https://www.postgresql.org/download/windows/
    echo.
    echo Browser opened. Follow the installation steps above.
)

echo.
echo After installing PostgreSQL:
echo 1. Restart your terminal
echo 2. Run this script again: install-postgresql.bat
echo 3. Or directly run: database\setup-database.bat
echo.
pause
