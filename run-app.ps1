# Employer-Worker Registration System - Run Script
# This script compiles and runs the application

Write-Host "========================================"  -ForegroundColor Cyan
Write-Host " Employer-Worker Registration System"    -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set JAVA_HOME
$env:JAVA_HOME = "C:\Program Files\Java\jdk-23"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

Write-Host "Checking Java installation..." -ForegroundColor Yellow
java -version
Write-Host ""

Write-Host "Compiling and starting application..." -ForegroundColor Green
Write-Host ""

.\gradlew.bat run

Write-Host ""
Write-Host "Application closed." -ForegroundColor Yellow
Read-Host "Press Enter to exit"
