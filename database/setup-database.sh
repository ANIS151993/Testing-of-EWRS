#!/bin/bash
# ============================================================
# Linux/Mac Script to Setup PostgreSQL Database
# for Employer-Worker Registration System
# ============================================================

echo ""
echo "========================================"
echo "PostgreSQL Database Setup"
echo "========================================"
echo ""

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "ERROR: PostgreSQL 'psql' command not found"
    echo ""
    echo "Please install PostgreSQL:"
    echo "  Ubuntu/Debian: sudo apt-get install postgresql"
    echo "  Mac: brew install postgresql"
    echo ""
    exit 1
fi

echo "PostgreSQL found:"
psql --version
echo ""

# Database configuration
DB_NAME="Hesap-eProject"
DB_USER="Hesap-eProject"
DB_PASS=".hesap-eProject."
DB_HOST="localhost"
DB_PORT="5432"

echo "Configuration:"
echo "  Database: $DB_NAME"
echo "  User:     $DB_USER"
echo "  Host:     $DB_HOST"
echo "  Port:     $DB_PORT"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Step 1: Create database and user
echo "Step 1: Creating database and user..."
echo ""
echo "Enter PostgreSQL superuser (postgres) password when prompted"
echo ""

# Drop existing database and user (if they exist)
sudo -u postgres psql -c "DROP DATABASE IF EXISTS \"$DB_NAME\";" 2>/dev/null
sudo -u postgres psql -c "DROP USER IF EXISTS \"$DB_USER\";" 2>/dev/null

# Create user
sudo -u postgres psql -c "CREATE USER \"$DB_USER\" WITH PASSWORD '$DB_PASS';"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create user"
    exit 1
fi

# Create database
sudo -u postgres psql -c "CREATE DATABASE \"$DB_NAME\" OWNER \"$DB_USER\";"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create database"
    exit 1
fi

# Grant privileges
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_USER\";"

echo ""
echo "Database and user created successfully!"
echo ""

# Step 2: Create schema
echo "Step 2: Creating database schema..."
echo ""

export PGPASSWORD="$DB_PASS"
psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f "$SCRIPT_DIR/schema.sql"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create schema"
    exit 1
fi

echo ""
echo "Schema created successfully!"
echo ""

# Step 3: Insert sample data
echo "Step 3: Inserting sample data..."
echo ""

read -p "Do you want to insert sample data? (Y/N): " INSERT_DATA
if [[ "$INSERT_DATA" =~ ^[Yy]$ ]]; then
    psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f "$SCRIPT_DIR/sample-data.sql"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to insert sample data"
        exit 1
    fi
    echo ""
    echo "Sample data inserted successfully!"
else
    echo "Skipping sample data insertion."
fi

unset PGPASSWORD

echo ""
echo "========================================"
echo "Database setup complete!"
echo "========================================"
echo ""
echo "Connection details:"
echo "  JDBC URL: jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
echo "  Username: $DB_USER"
echo "  Password: $DB_PASS"
echo ""
echo "Login credentials:"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "You can now run the application!"
echo ""
