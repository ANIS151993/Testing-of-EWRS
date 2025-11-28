# Complete Database Setup Script for Hesap-eProject
# This script will:
# 1. Prompt for postgres password
# 2. Create database and user
# 3. Set up schema
# 4. Load sample data

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Hesap-eProject Database Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get PostgreSQL installation path
$psqlPath = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

if (-not (Test-Path $psqlPath)) {
    Write-Host "ERROR: PostgreSQL not found at: $psqlPath" -ForegroundColor Red
    Write-Host "Please update the script with the correct PostgreSQL installation path." -ForegroundColor Yellow
    exit 1
}

# Prompt for postgres password
$postgresPassword = Read-Host -Prompt "Enter postgres password" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($postgresPassword)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

Write-Host ""
Write-Host "Step 1: Creating database and user..." -ForegroundColor Yellow

# Set PGPASSWORD environment variable
$env:PGPASSWORD = $plainPassword

# Create database and user
$createDbSql = @"
DROP DATABASE IF EXISTS "Hesap-eProject";
DROP USER IF EXISTS "Hesap-eProject";
CREATE USER "Hesap-eProject" WITH PASSWORD '.hesap-eProject.';
CREATE DATABASE "Hesap-eProject" WITH OWNER = "Hesap-eProject" ENCODING = 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE "Hesap-eProject" TO "Hesap-eProject";
"@

# Execute database creation
$createDbSql | & $psqlPath -U postgres -h localhost -p 5432 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "Database and user created successfully!" -ForegroundColor Green
} else {
    Write-Host "Failed to create database and user" -ForegroundColor Red
    Write-Host "Error: Incorrect password or PostgreSQL connection issue" -ForegroundColor Red
    $env:PGPASSWORD = $null
    exit 1
}

Write-Host ""
Write-Host "Step 2: Setting up database schema..." -ForegroundColor Yellow

# Now connect with the new user to create schema
$env:PGPASSWORD = ".hesap-eProject."

# Execute schema.sql
& $psqlPath -U "Hesap-eProject" -d "Hesap-eProject" -h localhost -p 5432 -f "schema.sql" 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "Schema created successfully!" -ForegroundColor Green
} else {
    Write-Host "Failed to create schema" -ForegroundColor Red
    $env:PGPASSWORD = $null
    exit 1
}

Write-Host ""
Write-Host "Step 3: Loading sample data..." -ForegroundColor Yellow

# Execute sample-data.sql
& $psqlPath -U "Hesap-eProject" -d "Hesap-eProject" -h localhost -p 5432 -f "sample-data.sql" 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "Sample data loaded successfully!" -ForegroundColor Green
} else {
    Write-Host "Failed to load sample data" -ForegroundColor Red
    $env:PGPASSWORD = $null
    exit 1
}

# Clear password from environment
$env:PGPASSWORD = $null

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Database Details:" -ForegroundColor Cyan
Write-Host "  Database: Hesap-eProject" -ForegroundColor White
Write-Host "  User: Hesap-eProject" -ForegroundColor White
Write-Host "  Password: .hesap-eProject." -ForegroundColor White
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Port: 5432" -ForegroundColor White
Write-Host ""
Write-Host "Test Login Credentials:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Password: admin" -ForegroundColor White
Write-Host ""
