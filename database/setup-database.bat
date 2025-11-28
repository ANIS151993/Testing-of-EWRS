@echo off
REM ============================================================
REM Windows Batch Script to Setup PostgreSQL Database
REM for Employer-Worker Registration System
REM ============================================================

echo.
echo ========================================
echo PostgreSQL Database Setup
echo ========================================
echo.

REM Check if PostgreSQL is in PATH
where psql >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: PostgreSQL 'psql' command not found in PATH
    echo.
    echo Please install PostgreSQL or add it to your system PATH:
    echo Example: C:\Program Files\PostgreSQL\16\bin
    echo.
    pause
    exit /b 1
)

echo PostgreSQL found: 
psql --version
echo.

REM Database configuration
set DB_NAME=Hesap-eProject
set DB_USER=Hesap-eProject
set DB_PASS=.hesap-eProject.
set DB_HOST=localhost
set DB_PORT=5432

echo Configuration:
echo   Database: %DB_NAME%
echo   User:     %DB_USER%
echo   Host:     %DB_HOST%
echo   Port:     %DB_PORT%
echo.

REM Optional: use PGPASSWORD if provided to avoid interactive prompts for superuser
set "PGPASS_FLAG="
if not "%PGPASSWORD%"=="" set "PGPASS_FLAG=-w"

REM Ask for PostgreSQL admin password
echo Enter PostgreSQL superuser (postgres) password when prompted
echo.

REM Step 1: Create database and user
echo Step 1: Creating database and user...
echo.

psql %PGPASS_FLAG% -U postgres -h %DB_HOST% -p %DB_PORT% -c "DROP DATABASE IF EXISTS \"%DB_NAME%\";" 2>nul
psql %PGPASS_FLAG% -U postgres -h %DB_HOST% -p %DB_PORT% -c "DROP USER IF EXISTS \"%DB_USER%\";" 2>nul

psql %PGPASS_FLAG% -U postgres -h %DB_HOST% -p %DB_PORT% -c "CREATE USER \"%DB_USER%\" WITH PASSWORD '%DB_PASS%';"
if %errorlevel% neq 0 (
    echo ERROR: Failed to create user
    pause
    exit /b 1
)

psql %PGPASS_FLAG% -U postgres -h %DB_HOST% -p %DB_PORT% -c "CREATE DATABASE \"%DB_NAME%\" OWNER \"%DB_USER%\";"
if %errorlevel% neq 0 (
    echo ERROR: Failed to create database
    pause
    exit /b 1
)

psql %PGPASS_FLAG% -U postgres -h %DB_HOST% -p %DB_PORT% -c "GRANT ALL PRIVILEGES ON DATABASE \"%DB_NAME%\" TO \"%DB_USER%\";"

echo.
echo Database and user created successfully!
echo.

REM Step 2: Create schema
echo Step 2: Creating database schema...
echo.

REM Use DB user password for following steps to avoid prompts
set "PGPASSWORD=%DB_PASS%"
psql -w -U "%DB_USER%" -h %DB_HOST% -p %DB_PORT% -d "%DB_NAME%" -f "%~dp0schema.sql"
if %errorlevel% neq 0 (
    echo ERROR: Failed to create schema
    pause
    exit /b 1
)

echo.
echo Schema created successfully!
echo.

REM Step 3: Insert sample data
echo Step 3: Inserting sample data...
echo.

set /p INSERT_DATA="Do you want to insert sample data? (Y/N): "
if /i "%INSERT_DATA%"=="Y" (
    psql -w -U "%DB_USER%" -h %DB_HOST% -p %DB_PORT% -d "%DB_NAME%" -f "%~dp0sample-data.sql"
    if %errorlevel% neq 0 (
        echo ERROR: Failed to insert sample data
        pause
        exit /b 1
    )
    echo.
    echo Sample data inserted successfully!
) else (
    echo Skipping sample data insertion.
)

echo.
echo ========================================
echo Database setup complete!
echo ========================================
echo.
echo Connection details:
echo   JDBC URL: jdbc:postgresql://%DB_HOST%:%DB_PORT%/%DB_NAME%
echo   Username: %DB_USER%
echo   Password: %DB_PASS%
echo.
echo Login credentials:
echo   Username: admin
echo   Password: admin
echo.
echo You can now run the application!
echo.
pause
