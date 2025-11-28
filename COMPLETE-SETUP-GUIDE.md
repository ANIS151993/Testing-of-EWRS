# 🚀 Complete Setup Guide - Employer Worker Registration System

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [PostgreSQL Installation](#postgresql-installation)
3. [Database Setup](#database-setup)
4. [Application Setup](#application-setup)
5. [Running the Application](#running-the-application)
6. [Testing All Features](#testing-all-features)
7. [Troubleshooting](#troubleshooting)

---

## ✅ Prerequisites

### Required Software:
- **Java JDK 23** ✅ (Already installed at: `C:\Program Files\Java\jdk-23`)
- **Gradle 8.11.1** ✅ (Already configured via wrapper)
- **PostgreSQL 16+** ❌ (Needs to be installed)
- **VS Code** ✅ (Already configured)

---

## 🐘 PostgreSQL Installation

### Step 1: Download PostgreSQL
1. Visit: https://www.postgresql.org/download/windows/
2. Download PostgreSQL 16 installer (latest stable version)
3. Run the installer

### Step 2: PostgreSQL Installation Settings
During installation, use these settings:
- **Installation Directory**: `C:\Program Files\PostgreSQL\16`
- **Data Directory**: `C:\Program Files\PostgreSQL\16\data`
- **Port**: `5432` (default)
- **Superuser Password**: Choose a strong password and **REMEMBER IT**
- **Components**: Install all (PostgreSQL Server, pgAdmin 4, Command Line Tools)

### Step 3: Add PostgreSQL to PATH
After installation:
1. Open System Properties → Environment Variables
2. Edit the **Path** variable (System variables)
3. Add: `C:\Program Files\PostgreSQL\16\bin`
4. Click OK and restart your terminal/PowerShell

### Step 4: Verify Installation
```powershell
psql --version
```
You should see: `psql (PostgreSQL) 16.x`

---

## 🗄️ Database Setup

### Option A: Automated Setup (Recommended)

1. **Open PowerShell** in the project directory
2. **Run the setup script**:
```powershell
cd database
.\setup-database.bat
```

3. **Follow the prompts**:
   - Enter your PostgreSQL superuser (postgres) password when prompted
   - Choose `Y` when asked to insert sample data (recommended for testing)

### Option B: Manual Setup

If the automated script fails, use these commands:

```powershell
# 1. Create the database user
psql -U postgres -c "CREATE USER \"Hesap-eProject\" WITH PASSWORD '.hesap-eProject.';"

# 2. Create the database
psql -U postgres -c "CREATE DATABASE \"Hesap-eProject\" OWNER \"Hesap-eProject\";"

# 3. Grant privileges
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE \"Hesap-eProject\" TO \"Hesap-eProject\";"

# 4. Create schema
psql -U Hesap-eProject -d Hesap-eProject -f database\schema.sql

# 5. Insert sample data (optional but recommended)
psql -U Hesap-eProject -d Hesap-eProject -f database\sample-data.sql
```

### Database Credentials
```
Database Name: Hesap-eProject
Username:      Hesap-eProject
Password:      .hesap-eProject.
Host:          localhost
Port:          5432
```

---

## 🔧 Application Setup

The application is already configured! Just verify:

### 1. Check Gradle Configuration
File: `build.gradle` ✅
- PostgreSQL JDBC driver: `org.postgresql:postgresql:42.7.4`
- Memory settings: `-Xmx512m -Xms256m`
- Main class: `com.cbozan.main.Main`

### 2. Check Database Connection
File: `src/com/cbozan/dao/DB.java` ✅
- JDBC URL: `jdbc:postgresql://localhost:5432/Hesap-eProject`
- Username: `Hesap-eProject`
- Password: `.hesap-eProject.`

---

## ▶️ Running the Application

### Method 1: Using VS Code (Easiest)
1. Open the project in VS Code
2. Press **F5** or click "Run" → "Start Debugging"
3. The application will build and launch automatically

### Method 2: Using Gradle Command
```powershell
.\gradlew run
```

### Method 3: Using Batch File
```powershell
.\gradle-run.bat
```

### Login Credentials
```
Username: admin
Password: admin
```

---

## 🧪 Testing All Features

### 1. Login Test ✅
- Open application
- Username: `admin`
- Password: `admin`
- Click "Giriş" (Login)

### 2. Employer Management Test
**Add New Employer:**
- Menu: `Kayıt` → `İşveren Ekle` (Record → Add Employer)
- Fill in: First Name, Last Name, Phone(s), Description
- Click "Kaydet" (Save)

**View Employers:**
- Menu: `Göster` → `İşverenler` (Display → Employers)
- Browse existing employers
- Edit or delete records

### 3. Worker Management Test
**Add New Worker:**
- Menu: `Kayıt` → `İşçi Ekle` (Record → Add Worker)
- Fill in: First Name, Last Name, Phone(s), IBAN, Description
- Click "Kaydet" (Save)

**View Workers:**
- Menu: `Göster` → `İşçiler` (Display → Workers)
- Browse existing workers
- Edit or delete records

### 4. Job Management Test
**Add New Job:**
- Menu: `Kayıt` → `İş Ekle` (Record → Add Job)
- Select Employer
- Select Price
- Enter Title and Description
- Click "Kaydet" (Save)

**View Jobs:**
- Menu: `Göster` → `İşler` (Display → Jobs)
- Browse existing jobs
- View job details

### 5. Price Management Test
**Add New Price:**
- Menu: `Kayıt` → `Fiyat Ekle` (Record → Add Price)
- Enter Full-time, Half-time, Overtime rates
- Click "Kaydet" (Save)

### 6. Work Recording Test
**Add Work:**
- Menu: `Ekle` → `İş Kaydı Ekle` (Add → Add Work Record)
- Select Job, Worker, Work Type
- Enter details
- Click "Kaydet" (Save)

### 7. Payment Processing Test
**Record Worker Payment:**
- Menu: `Ekle` → `İşçi Ödemesi` (Add → Worker Payment)
- Select Worker, Job
- Enter amount and payment type
- Click "Kaydet" (Save)

**Record Job Payment:**
- Menu: `Ekle` → `İş Ödemesi` (Add → Job Payment)
- Select Job
- Enter amount and payment type
- Click "Kaydet" (Save)

---

## 🔍 Troubleshooting

### Issue 1: "PostgreSQL not found"
**Solution:**
1. Ensure PostgreSQL is installed
2. Add to PATH: `C:\Program Files\PostgreSQL\16\bin`
3. Restart PowerShell/VS Code
4. Verify: `psql --version`

### Issue 2: "Database connection failed"
**Solution:**
1. Check if PostgreSQL service is running:
   ```powershell
   Get-Service -Name postgresql*
   ```
2. If stopped, start it:
   ```powershell
   Start-Service -Name postgresql-x64-16
   ```
3. Verify database exists:
   ```powershell
   psql -U postgres -l
   ```
4. Look for `Hesap-eProject` in the list

### Issue 3: "Password authentication failed"
**Solution:**
1. Check credentials in `DB.java`:
   - Username: `Hesap-eProject`
   - Password: `.hesap-eProject.`
2. Recreate user if needed:
   ```powershell
   psql -U postgres -c "DROP USER IF EXISTS \"Hesap-eProject\";"
   psql -U postgres -c "CREATE USER \"Hesap-eProject\" WITH PASSWORD '.hesap-eProject.';"
   ```

### Issue 4: "Could not find or load main class"
**Solution:**
1. Clean and rebuild:
   ```powershell
   .\gradlew clean build
   ```
2. Run again:
   ```powershell
   .\gradlew run
   ```

### Issue 5: "OutOfMemoryError: Java heap space"
**Solution:**
Already configured! Memory limits set to:
- Max heap: 512MB (`-Xmx512m`)
- Initial heap: 256MB (`-Xms256m`)

If still issues, reduce further in `build.gradle`:
```gradle
applicationDefaultJvmArgs = ['-Xmx384m', '-Xms192m']
```

### Issue 6: "Table does not exist"
**Solution:**
Recreate database schema:
```powershell
cd database
psql -U Hesap-eProject -d Hesap-eProject -f schema.sql
psql -U Hesap-eProject -d Hesap-eProject -f sample-data.sql
```

### Issue 7: Application starts but menus don't work
**Solution:**
1. Check database connection in console output
2. If "Database connected successfully" appears, database is OK
3. If errors appear, follow Issue 2 solution

---

## 📊 Sample Data Included

After running `sample-data.sql`, you'll have:
- **1 Admin user**: admin/admin
- **5 Employers**: Test employers with various details
- **8 Workers**: Test workers with IBANs and contact info
- **3 Price tiers**: Different pricing structures
- **3 Work types**: Installation, Maintenance, Repair
- **2 Payment types**: Cash, Bank Transfer
- **8 Jobs**: Sample jobs assigned to employers
- **5 Work groups**: Organized work assignments
- **10 Work records**: Individual work entries
- **6 Payments**: Sample payment records
- **3 Invoices**: Sample invoices

---

## 🎯 Quick Start Summary

```powershell
# 1. Install PostgreSQL 16 from postgresql.org

# 2. Add PostgreSQL to PATH
# Add: C:\Program Files\PostgreSQL\16\bin to system PATH

# 3. Setup database
cd database
.\setup-database.bat
# Enter postgres password when prompted
# Choose 'Y' for sample data

# 4. Run application
cd ..
.\gradlew run
# OR press F5 in VS Code

# 5. Login
# Username: admin
# Password: admin

# 6. Test all features!
```

---

## 📞 Support

If you encounter issues:
1. Check the Troubleshooting section above
2. Review console output for error messages
3. Verify PostgreSQL service is running
4. Ensure database was created successfully

---

## ✨ Features Summary

✅ **User Authentication**: Secure login system
✅ **Employer Management**: Add, edit, delete, display employers
✅ **Worker Management**: Complete worker CRUD operations
✅ **Job Management**: Job creation and assignment
✅ **Price Management**: Flexible pricing structures
✅ **Work Recording**: Track work performed
✅ **Payment Processing**: Worker and job payments
✅ **Invoice Generation**: Automatic invoice creation
✅ **Work Types**: Customizable work categories
✅ **Payment Types**: Multiple payment methods
✅ **Date Filtering**: Search by date ranges
✅ **IBAN Support**: International bank accounts
✅ **Phone Arrays**: Multiple phone numbers per person
✅ **Error Handling**: Graceful error management

---

## 🏆 Success Checklist

Before considering the application "perfectly workable", verify:

- [ ] PostgreSQL installed and running
- [ ] Database `Hesap-eProject` created
- [ ] Sample data loaded successfully
- [ ] Application starts without errors
- [ ] Login works with admin/admin
- [ ] Can add new employer
- [ ] Can add new worker
- [ ] Can add new job
- [ ] Can add new price
- [ ] Can record work
- [ ] Can process worker payment
- [ ] Can process job payment
- [ ] Can view all displays (Employers, Workers, Jobs)
- [ ] Can edit existing records
- [ ] Can delete records
- [ ] No database errors in console

---

**Application Status**: 🟢 READY TO USE (after PostgreSQL installation)

**Last Updated**: 2025-11-11
