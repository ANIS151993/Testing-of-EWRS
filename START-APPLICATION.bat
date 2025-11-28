@echo off
REM ============================================================
REM Smart Application Launcher with Database Verification
REM ============================================================

echo.
echo ========================================
echo Employer-Worker Registration System
echo ========================================
echo.

REM Step 1: Check if PostgreSQL is installed
echo [1/4] Checking PostgreSQL installation...
where psql >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ WARNING: PostgreSQL is not installed!
    echo.
    echo The application requires PostgreSQL to function properly.
    echo.
    set /p INSTALL="Would you like to see installation instructions? (Y/N): "
    if /i "%INSTALL%"=="Y" (
        call "%~dp0database\install-postgresql.bat"
        exit /b 1
    )
    echo.
    echo The application will start but with limited functionality.
    echo Please install PostgreSQL and setup the database for full features.
    echo.
    timeout /t 3 >nul
    goto :run_app
)

echo ✅ PostgreSQL is installed: 
psql --version
echo.

REM Step 2: Check if database exists
echo [2/4] Checking if database 'Hesap-eProject' exists...
psql -U postgres -l 2>nul | findstr /C:"Hesap-eProject" >nul
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ WARNING: Database 'Hesap-eProject' not found!
    echo.
    set /p SETUP="Would you like to setup the database now? (Y/N): "
    if /i "%SETUP%"=="Y" (
        echo.
        echo Running database setup...
        cd "%~dp0database"
        call setup-database.bat
        cd "%~dp0"
        if %errorlevel% neq 0 (
            echo.
            echo Database setup failed. Application will start with limited functionality.
            timeout /t 3 >nul
        ) else (
            echo.
            echo ✅ Database setup complete!
            echo.
        )
    ) else (
        echo.
        echo The application will start but with limited functionality.
        echo To setup database later, run: database\setup-database.bat
        echo.
        timeout /t 3 >nul
    )
) else (
    echo ✅ Database 'Hesap-eProject' found
    echo.
)

:run_app
REM Step 3: Build the application
echo [3/4] Building application...
call gradlew.bat build -x test --quiet
if %errorlevel% neq 0 (
    echo.
    echo ❌ Build failed! Check the errors above.
    pause
    exit /b 1
)
echo ✅ Build successful
echo.

REM Step 4: Run the application
echo [4/4] Starting application...
echo.
echo ===========================================
echo Login Credentials:
echo   Username: admin
echo   Password: admin
echo ===========================================
echo.
timeout /t 2 >nul

call gradlew.bat run

pause
