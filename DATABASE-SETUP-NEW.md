# 🎯 Complete Database Setup - UPDATED

## 🚀 AUTOMATED SETUP (EASIEST WAY!)

I've created fully automated setup scripts for you!

### Windows (Double-click and done!)
1. Navigate to the `database` folder
2. Double-click `setup-database.bat`
3. Enter your postgres password when asked
4. Type `Y` to insert sample data
5. **Done!** Login with username `admin`, password `admin`

### Linux/Mac
```bash
cd database
chmod +x setup-database.sh
./setup-database.sh
```

That's it! The script creates everything automatically.

---

## 📁 What's in the Database Folder

I've created a complete database setup package:

- **`schema.sql`** - Creates all 11 tables with proper relationships
- **`sample-data.sql`** - Inserts realistic test data (5 employers, 8 workers, 8 jobs, etc.)
- **`setup-database.bat`** - Automated Windows setup script
- **`setup-database.sh`** - Automated Linux/Mac setup script  
- **`README.md`** - Detailed documentation

---

## 🗃️ Database Structure

### Tables Created (11 total):
1. **admin** - Login credentials (admin/admin)
2. **employer** - Companies/people who hire workers
3. **worker** - People who do the work
4. **price** - Rate structures (fulltime/halftime/overtime)
5. **worktype** - Types: Full Time, Half Time, Overtime, etc.
6. **paytype** - Payment methods: Cash, Bank Transfer, etc.
7. **job** - Job postings by employers
8. **workgroup** - Organized work units
9. **work** - Individual work records
10. **payment** - Payment transactions
11. **invoice** - Billing records

### Sample Data Includes:
- ✅ 1 admin user (admin/admin)
- ✅ 5 employers (construction, restaurant, IT, events, landscaping)
- ✅ 8 workers (carpenter, chef, developer, coordinator, etc.)
- ✅ 4 pricing levels (standard, premium, economy, specialist)
- ✅ 5 work types + 5 payment types
- ✅ 8 complete jobs with workgroups, work records, payments, and invoices

**You can start using the app immediately with realistic data!**

---

## ⚡ Quick Verification

After running the setup script, test the connection:

```bash
psql -U "Hesap-eProject" -d "Hesap-eProject"
```

Then verify:
```sql
\dt                          -- Should show 11 tables
SELECT COUNT(*) FROM admin;  -- Should return 1
SELECT COUNT(*) FROM worker; -- Should return 8 (if sample data inserted)
\q
```

---

## 🎮 Run the Application

After database setup:

### Method 1: VS Code (Recommended)
Press **F5** - It will build and run automatically

### Method 2: Terminal
```batch
.\gradlew.bat run
```

### Method 3: Helper Script
```batch
.\setup-and-run.bat
```

**Login credentials:**
- Username: `admin`
- Password: `admin`

---

## 🎉 Test All Features

With sample data loaded, you can immediately:

### Record Menu
- **New Job** - Click to see pre-loaded employers in the search box
- **New Worker** - Add more workers to the existing 8
- **New Employer** - Add more employers
- **New Price** - See existing price structures

### Add Menu
- **Worker Payment** - Select from 8 workers and 8 jobs
- **Work** - Record work for existing jobs
- **Job Payment** - Process employer payments

### Display Menu
- **Display Job** - See all 8 jobs with details
- **Display Worker** - Browse worker cards
- **Display Employer** - View employer information

Everything works out of the box with realistic data!

---

## 🔧 Troubleshooting

### Script says "psql not found"
Add PostgreSQL bin folder to PATH:
- Windows: `C:\Program Files\PostgreSQL\16\bin`
- Then restart terminal

### "Authentication failed"
Your postgres user needs a password. Reset it:
```bash
psql -U postgres
ALTER USER postgres PASSWORD 'your_password';
\q
```

### Database Already Exists
The scripts automatically drop and recreate. Your old data will be lost. To backup:
```bash
pg_dump -U "Hesap-eProject" "Hesap-eProject" > backup.sql
```

### PostgreSQL Not Running
**Windows:**
```batch
net start postgresql-x64-16
```

**Linux:**
```bash
sudo service postgresql start
```

**Mac:**
```bash
brew services start postgresql
```

---

## 🎯 Connection Details

The app connects to:
```
Host:     localhost
Port:     5432  
Database: Hesap-eProject
Username: Hesap-eProject
Password: .hesap-eProject.
```

These are configured in `src/com/cbozan/dao/DB.java`

---

## 📖 Need More Help?

See `database/README.md` for:
- Manual setup instructions
- Detailed schema documentation
- Advanced troubleshooting
- Table relationship diagrams

---

**Enjoy your fully working application! 🚀**
