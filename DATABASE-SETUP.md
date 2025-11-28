# Database Setup Guide

## Overview
This application requires a PostgreSQL database named `Hesap-eProject`.

## Quick Setup

### Step 1: Install PostgreSQL

**Windows (PowerShell):**
```powershell
winget install -e --id PostgreSQL.PostgreSQL
```

Or download from: https://www.postgresql.org/download/windows/

### Step 2: Start PostgreSQL Service

**Windows:**
- Open Services (Win + R → `services.msc`)
- Find "postgresql-x64-XX" service
- Right-click → Start

Or via command:
```powershell
net start postgresql-x64-16
```

### Step 3: Create Database and User

**Option A: Using pgAdmin (GUI)**
1. Open pgAdmin
2. Connect to PostgreSQL server
3. Right-click "Databases" → Create → Database
4. Name: `Hesap-eProject`
5. Click Save

Then create user:
1. Right-click "Login/Group Roles" → Create → Login/Group Role
2. Name: `Hesap-eProject`
3. Go to "Definition" tab → Password: `.hesap-eProject.`
4. Go to "Privileges" tab → Enable "Can login?"
5. Click Save

**Option B: Using psql (Command Line)**
```bash
# Connect to PostgreSQL
psql -U postgres

# Create user
CREATE USER "Hesap-eProject" WITH PASSWORD '.hesap-eProject.';

# Create database
CREATE DATABASE "Hesap-eProject" OWNER "Hesap-eProject";

# Exit
\q
```

### Step 4: Create Tables

Connect to the database:
```bash
psql -U Hesap-eProject -d Hesap-eProject
```

Run these SQL commands:
```sql
CREATE TABLE admin(
    id smallserial primary key not null, 
    username varchar, 
    password varchar
);

CREATE TABLE employer(
    employer_id serial primary key not null, 
    name varchar not null, 
    surname varchar not null, 
    business varchar, 
    phonenumber varchar
);

CREATE TABLE worker(
    worker_id serial primary key not null, 
    name varchar not null, 
    surname varchar not null, 
    phone_number varchar
);

CREATE TABLE worker_record(
    worker_record_id serial primary key not null, 
    worker_id integer references worker(worker_id), 
    employer_id integer references employer(employer_id), 
    date varchar(10) not null, 
    wage smallint not null
);

CREATE TABLE employer_record(
    employer_record_id serial primary key not null, 
    employer_id integer references employer(employer_id), 
    date varchar(10) not null, 
    note varchar(255), 
    number_worker smallint not null, 
    wage smallint not null
);

CREATE TABLE worker_payment(
    worker_payment_id serial primary key not null, 
    worker_id integer references worker(worker_id), 
    employer_id integer references employer(employer_id), 
    date varchar(10) not null, 
    paid integer not null
);

CREATE TABLE employer_payment(
    employer_payment_id serial primary key not null, 
    employer_id integer references employer(employer_id), 
    date varchar(10) not null, 
    paid integer not null
);

-- Create initial admin user (username: admin, password: admin)
INSERT INTO admin (username, password) VALUES ('admin', 'admin');
```

### Step 5: Verify Setup

Test connection:
```bash
psql -U Hesap-eProject -d Hesap-eProject -c "\dt"
```

You should see all 7 tables listed.

## Database Connection Details

The application connects with these settings:
- **Host:** localhost
- **Port:** 5432
- **Database:** Hesap-eProject
- **Username:** Hesap-eProject
- **Password:** .hesap-eProject.

These are configured in: `src/com/cbozan/dao/DB.java`

## Troubleshooting

### Error: "No suitable driver found"
- **Solution:** This is fixed - the PostgreSQL JDBC driver is included via Gradle

### Error: "Connection refused"
- **Solution:** Ensure PostgreSQL service is running
- Windows: `net start postgresql-x64-16`

### Error: "Database does not exist"
- **Solution:** Create the database using Step 3 above

### Error: "Authentication failed"
- **Solution:** Verify username/password are correct
- Default: User=`Hesap-eProject`, Password=`.hesap-eProject.`

### Change Database Configuration

Edit `src/com/cbozan/dao/DB.java` line 30:
```java
conn = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/YOUR_DATABASE", 
    "YOUR_USERNAME", 
    "YOUR_PASSWORD"
);
```

Then rebuild:
```cmd
.\gradle-run.bat clean build
```

## Running Without Database

The application will start but show errors when accessing data features. You can:
1. Set up the database following this guide
2. Or modify the code to work without a database (requires development)

## Verification

After setup, run the application:
```cmd
setup-and-run.bat
```

You should see the login screen without errors.

## Default Login

After database setup:
- **Username:** admin
- **Password:** admin

You can change this in the admin table or create new users.
