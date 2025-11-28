@echo off
REM Complete setup and run script for Employer-Worker Registration System
SETLOCAL EnableDelayedExpansion

echo ============================================================
echo   Employer-Worker Registration System - Complete Setup
echo ============================================================
echo.

REM Set JAVA_HOME
SET JAVA_HOME=C:\Program Files\Java\jdk-23
SET PATH=%JAVA_HOME%\bin;%PATH%

REM Check Java
echo [1/5] Checking Java installation...
java -version 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java not found! Please install JDK 23.
    pause
    exit /b 1
)
echo OK - Java is installed
echo.

REM Stop any running Gradle daemons
echo [2/5] Stopping Gradle daemons...
gradlew.bat --stop >nul 2>&1
echo OK - Gradle daemons stopped
echo.

REM Clean and build
echo [3/5] Building application...
gradlew.bat clean build --no-daemon --quiet
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)
echo OK - Build successful
echo.

REM Check for PostgreSQL
echo [4/5] Checking database setup...
echo.
echo Database Configuration:
echo   - Database: Hesap-eProject
echo   - User: Hesap-eProject
echo   - Port: 5432
echo.
echo NOTE: If you see database errors when the app starts,
echo       you need to set up PostgreSQL database.
echo       See DATABASE-SETUP.md for instructions.
echo.
pause

REM Run application
echo [5/5] Starting application...
echo.
java -Xmx512m -Xms256m -cp "build\classes\java\main;%USERPROFILE%\.gradle\caches\modules-2\files-2.1\org.postgresql\postgresql\42.7.4\f4d55ac35dcbe061c19a1b6f6e45fbd981f0e656\postgresql-42.7.4.jar" com.cbozan.main.Main

echo.
echo Application closed.
pause
