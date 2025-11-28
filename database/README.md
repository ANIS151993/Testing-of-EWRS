# Database Setup Guide

## Quick Start (Windows)

1. **Install PostgreSQL** (if not already installed):
   - Download from: https://www.postgresql.org/download/windows/
   - Default port: 5432
   - Remember your postgres user password

2. **Run the automated setup**:
   ```batch
   cd database
   setup-database.bat
   ```
   - Enter postgres password when prompted
   - Choose 'Y' to insert sample data (recommended for testing)

3. **Done!** Run the application and login with:
   - Username: `admin`
   - Password: `admin`

---

## Quick Start (Linux/Mac)

1. **Install PostgreSQL**:
   - Ubuntu/Debian: `sudo apt-get install postgresql`
   - Mac: `brew install postgresql`

2. **Run the automated setup**:
   ```bash
   cd database
   chmod +x setup-database.sh
   ./setup-database.sh
   ```
   - Enter postgres password when prompted
   - Choose 'Y' to insert sample data (recommended for testing)

3. **Done!** Run the application and login with:
   - Username: `admin`
   - Password: `admin`

---

## Manual Setup

If you prefer manual setup or troubleshooting:

### Step 1: Connect to PostgreSQL
```bash
psql -U postgres
```

### Step 2: Create Database and User
```sql
CREATE USER "Hesap-eProject" WITH PASSWORD '.hesap-eProject.';
CREATE DATABASE "Hesap-eProject" OWNER "Hesap-eProject";
GRANT ALL PRIVILEGES ON DATABASE "Hesap-eProject" TO "Hesap-eProject";
\q
```

### Step 3: Create Schema
```bash
psql -U "Hesap-eProject" -d "Hesap-eProject" -f schema.sql
```

### Step 4: Insert Sample Data (Optional)
```bash
psql -U "Hesap-eProject" -d "Hesap-eProject" -f sample-data.sql
```

---

## Database Schema

### Tables Created:
1. **admin** - Login authentication
2. **employer** - Employers who post jobs
3. **worker** - Workers who perform jobs
4. **price** - Pricing structures (fulltime, halftime, overtime rates)
5. **worktype** - Types of work (Full Time, Half Time, Overtime, etc.)
6. **paytype** - Payment methods (Cash, Bank Transfer, etc.)
7. **job** - Jobs posted by employers
8. **workgroup** - Work groups for jobs
9. **work** - Individual work records
10. **payment** - Payment records to workers
11. **invoice** - Invoices for jobs

### Relationships:
- Jobs belong to Employers and have a Price structure
- Workgroups belong to Jobs and have a Worktype
- Work records link Workers to Jobs through Workgroups
- Payments track money paid to Workers for Jobs
- Invoices track billing for Jobs

---

## Sample Data Included

When you choose to insert sample data:
- **1 Admin user** (admin/admin)
- **5 Employers** (various businesses)
- **8 Workers** (with different skills)
- **4 Price structures** (different rate levels)
- **5 Work types** (Full Time, Half Time, Overtime, Night Shift, Weekend)
- **5 Payment types** (Cash, Bank Transfer, Check, Credit Card, Mobile Payment)
- **8 Jobs** (construction, IT, events, etc.)
- **10 Workgroups** (organized work units)
- **13 Work records** (worker assignments)
- **13 Payments** (payment history)
- **8 Invoices** (billing records)

This gives you realistic data to test all features of the application immediately!

---

## Connection Details

The application is pre-configured to connect to:
- **Host**: localhost
- **Port**: 5432
- **Database**: Hesap-eProject
- **Username**: Hesap-eProject
- **Password**: .hesap-eProject.

These are set in `src/com/cbozan/dao/DB.java`

---

## Troubleshooting

### "psql: command not found"
Add PostgreSQL to your PATH:
- Windows: `C:\Program Files\PostgreSQL\16\bin`
- Linux: Usually already in PATH after install
- Mac: `export PATH="/usr/local/opt/postgresql/bin:$PATH"`

### "peer authentication failed"
Edit `pg_hba.conf` and change authentication method to `md5`:
```
# Find this line:
local   all             all                                     peer
# Change to:
local   all             all                                     md5
```
Then restart PostgreSQL:
- Linux: `sudo service postgresql restart`
- Mac: `brew services restart postgresql`
- Windows: Services → PostgreSQL → Restart

### "database already exists"
The setup scripts will drop and recreate the database. If you want to preserve data, back it up first:
```bash
pg_dump -U "Hesap-eProject" "Hesap-eProject" > backup.sql
```

### Connection refused
Make sure PostgreSQL is running:
- Windows: Check Services for "postgresql-x64-16"
- Linux: `sudo service postgresql status`
- Mac: `brew services list`

---

## Verification

After setup, verify everything works:

```bash
psql -U "Hesap-eProject" -d "Hesap-eProject"
```

Then run:
```sql
-- Check all tables exist
\dt

-- Count records
SELECT 'admin' AS table, COUNT(*) FROM admin
UNION ALL SELECT 'employer', COUNT(*) FROM employer
UNION ALL SELECT 'worker', COUNT(*) FROM worker;

-- Test login
SELECT * FROM admin WHERE username='admin';
```

You should see:
- 11 tables listed
- Record counts (1 admin, 5 employers, 8 workers if you inserted sample data)
- Admin user record

---

## Next Steps

1. Run the application:
   ```batch
   .\gradlew.bat run
   ```

2. Login with:
   - Username: `admin`
   - Password: `admin`

3. Try the menus:
   - **Record** → Add new employers, workers, jobs, prices
   - **Add** → Record work and payments
   - **Display** → View employers, workers, and jobs

Enjoy! 🎉
