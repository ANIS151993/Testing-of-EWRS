param(
    [Parameter(Mandatory=$true)]
    [string]$NewPassword,
    [string]$DataDir = "C:\\Program Files\\PostgreSQL\\16\\data",
    [string]$ServiceName = "postgresql-x64-16"
)

Write-Host "PostgreSQL superuser password reset helper" -ForegroundColor Cyan

# Admin check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    exit 1
}

# Validate files
$hba = Join-Path $DataDir 'pg_hba.conf'
if (-not (Test-Path $hba)) {
    Write-Error "pg_hba.conf not found at: $hba`nIf PostgreSQL is installed elsewhere, re-run with -DataDir <path>"
    exit 1
}

# Stop service
Write-Host "Stopping service $ServiceName ..."
Stop-Service -Name $ServiceName -ErrorAction Stop

# Backup pg_hba.conf
$backup = "$hba.bak-$(Get-Date -Format yyyyMMddHHmmss)"
Copy-Item $hba $backup -Force
Write-Host "Backup created: $backup"

# Switch auth to trust for local connections
$content = Get-Content $hba
$content = $content -replace '(host\s+all\s+all\s+127\.0\.0\.1/32\s+)\S+','$1trust'
$content = $content -replace '(host\s+all\s+all\s+::1/128\s+)\S+','$1trust'
Set-Content -Path $hba -Value $content -Encoding UTF8
Write-Host "Temporarily set local auth to trust"

# Start service
Write-Host "Starting service $ServiceName ..."
Start-Service -Name $ServiceName -ErrorAction Stop
Start-Sleep -Seconds 2

# Change password without prompt
$env:PGPASSWORD = ''
$cmd = "ALTER USER postgres WITH PASSWORD '$NewPassword';"
Write-Host "Resetting postgres password ..."
$proc = Start-Process -FilePath "C:\\Program Files\\PostgreSQL\\16\\bin\\psql.exe" -ArgumentList "-U postgres -h localhost -p 5432 -c `"$cmd`"" -NoNewWindow -Wait -PassThru
if ($proc.ExitCode -ne 0) {
    Write-Error "Failed to reset password. ExitCode=$($proc.ExitCode)"
    # Attempt to restore before exit
    Copy-Item $backup $hba -Force
    Restart-Service -Name $ServiceName
    exit $proc.ExitCode
}

# Restore pg_hba.conf
Copy-Item $backup $hba -Force
Write-Host "Restored original pg_hba.conf"

# Restart service
Restart-Service -Name $ServiceName
Write-Host "Password reset complete. You can now use: $NewPassword" -ForegroundColor Green
