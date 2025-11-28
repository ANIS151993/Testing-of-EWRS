@echo off
REM Compile and run the employer-worker-registration-system application
REM This script sets JAVA_HOME and uses Gradle to run the app

SET JAVA_HOME=C:\Program Files\Java\jdk-23
SET PATH=%JAVA_HOME%\bin;%PATH%

echo ========================================
echo  Employer-Worker Registration System
echo ========================================
echo.
echo Compiling application...
echo.

REM Build without daemon to save memory
gradlew.bat build --no-daemon --quiet

if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo Starting application with reduced memory settings...
echo.

REM Run with limited heap to avoid memory issues
java -Xmx512m -Xms256m -cp "build\classes\java\main;%USERPROFILE%\.gradle\caches\modules-2\files-2.1\org.postgresql\postgresql\42.7.4\f4d55ac35dcbe061c19a1b6f6e45fbd981f0e656\postgresql-42.7.4.jar" com.cbozan.main.Main

pause
