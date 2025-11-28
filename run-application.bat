@echo off
REM Employer-Worker Registration System Launcher
REM This script sets up the environment and runs the application

echo ========================================
echo Employer-Worker Registration System
echo ========================================
echo.

REM Set JAVA_HOME
set JAVA_HOME=C:\Program Files\Java\jdk-23

REM Add PostgreSQL to PATH
set PATH=C:\Program Files\Java\jdk-23\bin;C:\Program Files\PostgreSQL\16\bin;%PATH%

echo Checking PostgreSQL service...
sc query postgresql-x64-16 | find "RUNNING" >nul
if errorlevel 1 (
    echo ERROR: PostgreSQL service is not running!
    echo Please start PostgreSQL service and try again.
    pause
    exit /b 1
)
echo PostgreSQL service is running.
echo.

echo Starting application...
echo Please wait...
echo.

REM Run the application
gradlew.bat run

echo.
echo Application closed.
pause
