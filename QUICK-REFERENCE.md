# 🎯 Quick Reference Guide

## Application Overview
**Employer-Worker Registration System** is a desktop application for managing:
- Employers and their contact information
- Workers and their payment details
- Jobs assigned to employers
- Work performed by workers
- Payments and invoices

---

## Menu Structure

### 📋 Record Menu (Kayıt)
Create new records in the system:

| Menu Item | Description | Fields |
|-----------|-------------|--------|
| **New Job** | Create new job assignment | Employer, Price, Title, Description |
| **New Worker** | Add new worker | First Name, Last Name, Phone(s), IBAN, Description |
| **New Employer** | Add new employer | First Name, Last Name, Phone(s), Description |
| **New Price** | Create pricing tier | Full-time, Half-time, Overtime rates |

### ➕ Add Menu (Ekle)
Add work records and payments:

| Menu Item | Description | Fields |
|-----------|-------------|--------|
| **Worker Payment** | Record payment to worker | Worker, Job, Payment Type, Amount |
| **Work** | Record work performed | Job, Worker, Work Type, Work Group, Description |
| **Job Payment** | Record payment for job | Job, Payment Type, Amount |

### 👁️ Display Menu (Göster)
View and manage existing records:

| Menu Item | Description | Features |
|-----------|-------------|----------|
| **Display Job** | View all jobs | List, Search, Edit, Delete |
| **Display Worker** | View all workers | List, Search, Edit, Delete |
| **Display Employer** | View all employers | List, Search, Edit, Delete |

---

## Common Operations

### Adding a New Employer
1. **Record** → **New Employer**
2. Fill in:
   - First Name (required)
   - Last Name (required)
   - Phone (optional, can add multiple separated by commas)
   - Description (optional)
3. Click **Save** button
4. Confirmation message appears

### Adding a New Worker
1. **Record** → **New Worker**
2. Fill in:
   - First Name (required)
   - Last Name (required)
   - Phone (optional, can add multiple separated by commas)
   - IBAN (optional, bank account number)
   - Description (optional)
3. Click **Save** button
4. Confirmation message appears

### Creating a Job
1. **Record** → **New Job**
2. Select **Employer** from dropdown
3. Select **Price** tier from dropdown
4. Fill in:
   - Title (required)
   - Description (optional)
5. Click **Save** button
6. Job is created and ready for work assignments

### Recording Work
1. **Add** → **Work**
2. Select **Job** from dropdown
3. Select **Worker** from dropdown
4. Select **Work Type** from dropdown
5. Select **Work Group** (if applicable)
6. Add description
7. Click **Save** button
8. Work is recorded in the database

### Processing Worker Payment
1. **Add** → **Worker Payment**
2. Select **Worker** from dropdown
3. Select **Job** from dropdown
4. Select **Payment Type** (Cash, Bank Transfer, etc.)
5. Enter **Amount** (e.g., 500.00)
6. Click **Save** button
7. Payment is recorded

### Searching Records
1. Navigate to appropriate **Display** menu
2. Enter search term in **Search Box** at top
3. List automatically filters to matching records
4. Clear search box to show all records again

### Editing Records
1. Navigate to appropriate **Display** menu
2. Select record from list (click on it)
3. Click **Edit** button (or double-click record)
4. Modify fields as needed
5. Click **Save** button
6. Record is updated

### Deleting Records
1. Navigate to appropriate **Display** menu
2. Select record from list
3. Click **Delete** button
4. Confirm deletion in dialog
5. Record is deleted from database

---

## Database Information

### Connection Details
```
Database: Hesap-eProject
Host:     localhost
Port:     5432
Username: Hesap-eProject
Password: .hesap-eProject.
```

### Login Credentials
```
Username: admin
Password: admin
```

---

## Database Tables

### Core Tables
- **admin** - User authentication
- **employer** - Employer records
- **worker** - Worker records
- **job** - Job assignments
- **price** - Pricing tiers

### Supporting Tables
- **worktype** - Types of work (Installation, Maintenance, Repair)
- **paytype** - Payment methods (Cash, Bank Transfer)
- **workgroup** - Organized work groups

### Transaction Tables
- **work** - Individual work records
- **payment** - Payment transactions
- **invoice** - Invoice records

---

## Data Types

### Phone Numbers
- Format: `555-0123` or `05551234567`
- Multiple phones: Separated by commas `555-0123, 555-0124`
- Stored as PostgreSQL array: `VARCHAR[]`

### IBAN
- Format: Country code + check digits + bank code + account number
- Example: `TR330006100519786457841326`
- Length: Up to 34 characters

### Money/Amounts
- Format: Decimal with 2 decimal places
- Example: `1234.56`
- Stored as: `DECIMAL(10,2)`

### Dates
- Display format: `dd/MM/yyyy` (e.g., `11/11/2025`)
- Database format: `TIMESTAMP`
- Automatically set to current time

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Tab | Move to next field |
| Shift+Tab | Move to previous field |
| Enter | Activate default button (usually Save) |
| Escape | Cancel/Close dialog |

---

## Tips & Best Practices

### Data Entry
✅ **Do:**
- Use consistent name formatting (e.g., always "John Doe", not "john doe")
- Enter complete IBAN numbers for accurate payments
- Add descriptions to help identify records later
- Use multiple phone numbers when available

❌ **Don't:**
- Leave required fields empty
- Enter duplicate records (system will prevent this)
- Delete records with active dependencies
- Use special characters in phone numbers (use only digits and hyphens)

### Search & Filter
✅ **Do:**
- Use partial names for broader search (e.g., "John" finds "John Doe")
- Clear search box to see all records
- Use date ranges for work history filtering

❌ **Don't:**
- Search with too specific terms if you're not finding results
- Forget to clear previous filters

### Payments
✅ **Do:**
- Verify worker and job before recording payment
- Double-check amount before saving
- Use appropriate payment type (Cash vs Bank Transfer)
- Keep track of total payments per job

❌ **Don't:**
- Process duplicate payments
- Forget to record all payments
- Enter negative amounts

### Performance
✅ **Do:**
- Close unused display windows
- Use search/filter to reduce loaded records
- Regularly refresh displays to see latest data

---

## Common Issues & Solutions

### Issue: "Database connection failed"
**Solution:** 
1. Verify PostgreSQL is running: `Get-Service postgresql*`
2. Check database exists: `psql -U postgres -l`
3. Verify credentials in DB.java

### Issue: "Record already exists"
**Solution:** 
- System prevents duplicates
- Edit existing record instead of creating new one
- Or delete old record first (if appropriate)

### Issue: "Cannot delete record"
**Solution:** 
- Record may have dependencies (e.g., job with work records)
- Delete dependent records first
- Or use cascade delete (automatic in some cases)

### Issue: Menu not responding
**Solution:** 
1. Close and reopen the application
2. Check console for error messages
3. Verify database connection is active

---

## File Locations

### Application Files
```
employer-worker-registration-system/
├── src/                      # Source code
├── database/                 # Database scripts
│   ├── schema.sql           # Database structure
│   ├── sample-data.sql      # Test data
│   └── setup-database.bat   # Setup script
├── build.gradle             # Build configuration
├── start-application.bat    # Smart launcher
└── README.md                # Documentation
```

### Generated Files
```
build/
├── classes/java/main/       # Compiled .class files
├── libs/                    # Generated JAR files
└── tmp/                     # Temporary build files
```

---

## Version Information

- **Application Version**: 1.0.0
- **Java Version**: 23
- **Gradle Version**: 8.11.1
- **PostgreSQL JDBC**: 42.7.4
- **Minimum PostgreSQL**: 16+

---

## Support Resources

📖 **Documentation:**
- [README.md](README.md) - Main documentation
- [COMPLETE-SETUP-GUIDE.md](COMPLETE-SETUP-GUIDE.md) - Detailed setup instructions
- [TESTING-CHECKLIST.md](TESTING-CHECKLIST.md) - Comprehensive testing guide

🔧 **Setup Scripts:**
- `start-application.bat` - Smart launcher with database checks
- `database/setup-database.bat` - Database setup script
- `database/install-postgresql.bat` - PostgreSQL installation helper

💻 **Running Application:**
- `.\start-application.bat` - Recommended method
- `.\gradlew run` - Direct Gradle execution
- Press F5 in VS Code - IDE integration

---

## Quick Start Summary

```powershell
# 1. Install PostgreSQL 16
# Download from: https://www.postgresql.org/download/windows/

# 2. Setup database
cd database
.\setup-database.bat
# Enter postgres password
# Choose 'Y' for sample data

# 3. Run application
cd ..
.\start-application.bat

# 4. Login
# Username: admin
# Password: admin

# 5. Start using the application!
```

---

**Created**: 2025-11-11  
**Status**: ✅ Production Ready  
**License**: MIT
