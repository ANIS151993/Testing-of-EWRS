# 🧪 Complete Testing Checklist

## Purpose
This document provides a comprehensive testing checklist to verify that ALL sections of the Employer-Worker Registration System are working perfectly.

---

## Pre-Testing Requirements

### Environment Setup
- [ ] Java JDK 23 installed and JAVA_HOME set
- [ ] PostgreSQL 16+ installed and running
- [ ] PostgreSQL service is active: `Get-Service postgresql*`
- [ ] Database `Hesap-eProject` exists: `psql -U postgres -l | findstr Hesap`
- [ ] Sample data loaded successfully
- [ ] Application builds without errors: `.\gradlew build`

---

## Section 1: Authentication & Login ✅

### Test 1.1: Default Admin Login
- [ ] Start application
- [ ] Enter username: `admin`
- [ ] Enter password: `admin`
- [ ] Click "Giriş" button
- [ ] **Expected**: Main application window opens
- [ ] **Status**: ___________

### Test 1.2: Invalid Login
- [ ] Start application
- [ ] Enter username: `wronguser`
- [ ] Enter password: `wrongpass`
- [ ] Click "Giriş" button
- [ ] **Expected**: Login fails, error message shown
- [ ] **Status**: ___________

### Test 1.3: Database Login
- [ ] Verify admin exists in database: `SELECT * FROM admin WHERE username='admin';`
- [ ] **Expected**: Record found with username 'admin'
- [ ] **Status**: ___________

---

## Section 2: Employer Management 📋

### Test 2.1: Add New Employer
- [ ] Login to application
- [ ] Navigate to: **Kayıt** → **İşveren Ekle** (Record → Add Employer)
- [ ] Fill in form:
  - First Name: `Test`
  - Last Name: `Employer`
  - Phone: `555-0100`
  - Description: `Test employer for verification`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Success message, record saved
- [ ] **Status**: ___________

### Test 2.2: View Employers List
- [ ] Navigate to: **Göster** → **İşverenler** (Display → Employers)
- [ ] **Expected**: List of employers displayed (should include test employer from 2.1)
- [ ] **Status**: ___________

### Test 2.3: Search Employer
- [ ] In Employer Display, use search box
- [ ] Enter: `Test`
- [ ] **Expected**: Filters to show only matching employers
- [ ] **Status**: ___________

### Test 2.4: Edit Employer
- [ ] In Employer Display, select test employer
- [ ] Click "Düzenle" (Edit) or double-click
- [ ] Modify: Description to `Updated test employer`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Record updated successfully
- [ ] **Status**: ___________

### Test 2.5: Delete Employer
- [ ] In Employer Display, select test employer
- [ ] Click "Sil" (Delete)
- [ ] Confirm deletion
- [ ] **Expected**: Record deleted, removed from list
- [ ] **Status**: ___________

### Test 2.6: Duplicate Prevention
- [ ] Add employer: `John Doe`
- [ ] Try to add another employer: `John Doe`
- [ ] **Expected**: Error message about duplicate
- [ ] **Status**: ___________

---

## Section 3: Worker Management 👷

### Test 3.1: Add New Worker
- [ ] Navigate to: **Kayıt** → **İşçi Ekle** (Record → Add Worker)
- [ ] Fill in form:
  - First Name: `Test`
  - Last Name: `Worker`
  - Phone: `555-0200`
  - IBAN: `TR330006100519786457841326`
  - Description: `Test worker for verification`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Success message, record saved
- [ ] **Status**: ___________

### Test 3.2: View Workers List
- [ ] Navigate to: **Göster** → **İşçiler** (Display → Workers)
- [ ] **Expected**: List of workers displayed (should include test worker from 3.1)
- [ ] **Status**: ___________

### Test 3.3: Search Worker
- [ ] In Worker Display, use search box
- [ ] Enter: `Test`
- [ ] **Expected**: Filters to show only matching workers
- [ ] **Status**: ___________

### Test 3.4: Edit Worker
- [ ] In Worker Display, select test worker
- [ ] Click "Düzenle" (Edit) or double-click
- [ ] Modify: IBAN to different valid IBAN
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Record updated successfully
- [ ] **Status**: ___________

### Test 3.5: Delete Worker
- [ ] In Worker Display, select test worker
- [ ] Click "Sil" (Delete)
- [ ] Confirm deletion
- [ ] **Expected**: Record deleted, removed from list
- [ ] **Status**: ___________

### Test 3.6: Multiple Phone Numbers
- [ ] Add worker with multiple phones
- [ ] Enter phones separated by commas: `555-0201, 555-0202, 555-0203`
- [ ] Save and verify all phones stored
- [ ] **Expected**: All phone numbers saved and displayed
- [ ] **Status**: ___________

---

## Section 4: Price Management 💰

### Test 4.1: Add New Price
- [ ] Navigate to: **Kayıt** → **Fiyat Ekle** (Record → Add Price)
- [ ] Fill in form:
  - Full-time: `1000.00`
  - Half-time: `500.00`
  - Overtime: `150.00`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Success message, price tier saved
- [ ] **Status**: ___________

### Test 4.2: View Prices
- [ ] Check price list in dropdown menus (Job creation)
- [ ] **Expected**: New price tier appears in selection
- [ ] **Status**: ___________

### Test 4.3: Edit Price
- [ ] Navigate back to price management
- [ ] Select created price
- [ ] Modify: Full-time to `1100.00`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Price updated successfully
- [ ] **Status**: ___________

### Test 4.4: Decimal Precision
- [ ] Add price with decimal values: `1234.56`
- [ ] Save and verify
- [ ] **Expected**: Decimal places preserved correctly
- [ ] **Status**: ___________

---

## Section 5: Job Management 💼

### Test 5.1: Add New Job
- [ ] Navigate to: **Kayıt** → **İş Ekle** (Record → Add Job)
- [ ] Select employer from dropdown
- [ ] Select price tier from dropdown
- [ ] Fill in:
  - Title: `Test Job Project`
  - Description: `Testing job creation functionality`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Success message, job created
- [ ] **Status**: ___________

### Test 5.2: View Jobs List
- [ ] Navigate to: **Göster** → **İşler** (Display → Jobs)
- [ ] **Expected**: List of jobs displayed (should include test job)
- [ ] **Status**: ___________

### Test 5.3: Job Details
- [ ] In Job Display, select test job
- [ ] View job details
- [ ] **Expected**: Shows employer, price, title, description correctly
- [ ] **Status**: ___________

### Test 5.4: Edit Job
- [ ] In Job Display, select test job
- [ ] Click "Düzenle" (Edit)
- [ ] Modify: Description to `Updated job description`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Job updated successfully
- [ ] **Status**: ___________

### Test 5.5: Delete Job
- [ ] In Job Display, select test job
- [ ] Click "Sil" (Delete)
- [ ] Confirm deletion
- [ ] **Expected**: Job deleted (cascade delete should remove related records)
- [ ] **Status**: ___________

---

## Section 6: Work Type Management 🔧

### Test 6.1: Add Work Type
- [ ] Navigate to work type management
- [ ] Add new work type:
  - Title: `Testing`
  - Number: `99`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Work type created
- [ ] **Status**: ___________

### Test 6.2: View Work Types
- [ ] Check work type dropdown in work recording
- [ ] **Expected**: New work type appears in selection
- [ ] **Status**: ___________

---

## Section 7: Payment Type Management 💳

### Test 7.1: Add Payment Type
- [ ] Navigate to payment type management
- [ ] Add new payment type:
  - Title: `Credit Card`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Payment type created
- [ ] **Status**: ___________

### Test 7.2: View Payment Types
- [ ] Check payment type dropdown in payment processing
- [ ] **Expected**: New payment type appears in selection
- [ ] **Status**: ___________

---

## Section 8: Work Recording 📝

### Test 8.1: Add Work Record
- [ ] Navigate to: **Ekle** → **İş Kaydı Ekle** (Add → Add Work Record)
- [ ] Select job from dropdown
- [ ] Select worker from dropdown
- [ ] Select work type from dropdown
- [ ] Select work group (if applicable)
- [ ] Fill in description
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Work record created
- [ ] **Status**: ___________

### Test 8.2: View Work Records
- [ ] Navigate to work record display
- [ ] Filter by worker
- [ ] **Expected**: Shows work records for selected worker
- [ ] **Status**: ___________

### Test 8.3: Date Range Filter
- [ ] In work record display
- [ ] Enter date range: `01/11/2025-11/11/2025`
- [ ] Click filter/search
- [ ] **Expected**: Shows only records within date range
- [ ] **Status**: ___________

---

## Section 9: Payment Processing 💵

### Test 9.1: Worker Payment
- [ ] Navigate to: **Ekle** → **İşçi Ödemesi** (Add → Worker Payment)
- [ ] Select worker from dropdown
- [ ] Select job from dropdown
- [ ] Select payment type
- [ ] Enter amount: `500.00`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Payment recorded successfully
- [ ] **Status**: ___________

### Test 9.2: Job Payment
- [ ] Navigate to: **Ekle** → **İş Ödemesi** (Add → Job Payment)
- [ ] Select job from dropdown
- [ ] Select payment type
- [ ] Enter amount: `5000.00`
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Payment recorded successfully
- [ ] **Status**: ___________

### Test 9.3: Payment History
- [ ] View payment records for worker
- [ ] **Expected**: Shows all payments made to worker
- [ ] **Status**: ___________

### Test 9.4: Payment Sum Calculation
- [ ] View total payments for job
- [ ] **Expected**: Correctly sums all payments
- [ ] **Status**: ___________

---

## Section 10: Invoice Generation 📄

### Test 10.1: Create Invoice
- [ ] Navigate to invoice management
- [ ] Select job
- [ ] Generate invoice
- [ ] Enter amount
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Invoice created successfully
- [ ] **Status**: ___________

### Test 10.2: View Invoices
- [ ] Navigate to invoice display
- [ ] **Expected**: Shows list of invoices with job details
- [ ] **Status**: ___________

---

## Section 11: Work Groups 👥

### Test 11.1: Create Work Group
- [ ] Navigate to work group management
- [ ] Select job
- [ ] Select work type
- [ ] Enter work count
- [ ] Add description
- [ ] Click "Kaydet" (Save)
- [ ] **Expected**: Work group created
- [ ] **Status**: ___________

### Test 11.2: Assign Workers to Work Group
- [ ] Select work group
- [ ] Add workers to group
- [ ] **Expected**: Workers assigned to group
- [ ] **Status**: ___________

---

## Section 12: Database Integrity 🗄️

### Test 12.1: Foreign Key Constraints
- [ ] Try to delete employer with assigned jobs
- [ ] **Expected**: Cascade delete or constraint error (depending on schema)
- [ ] **Status**: ___________

### Test 12.2: Data Persistence
- [ ] Close application
- [ ] Restart application
- [ ] Login again
- [ ] Verify data still exists
- [ ] **Expected**: All data persists across sessions
- [ ] **Status**: ___________

### Test 12.3: Phone Array Storage
- [ ] Add entity with multiple phones
- [ ] Query database: `SELECT tel FROM employer WHERE fname='Test';`
- [ ] **Expected**: Phone array stored correctly in PostgreSQL
- [ ] **Status**: ___________

---

## Section 13: Error Handling 🚨

### Test 13.1: Database Disconnection
- [ ] Stop PostgreSQL service
- [ ] Try to perform operation in application
- [ ] **Expected**: Graceful error message displayed
- [ ] **Status**: ___________

### Test 13.2: Invalid Input
- [ ] Try to save record with empty required fields
- [ ] **Expected**: Validation error message
- [ ] **Status**: ___________

### Test 13.3: SQL Injection Prevention
- [ ] Try to enter SQL commands in text fields: `'; DROP TABLE admin; --`
- [ ] **Expected**: Treated as regular text, no SQL execution
- [ ] **Status**: ___________

---

## Section 14: Performance 🚀

### Test 14.1: Large Dataset
- [ ] Verify sample data loaded (8 workers, 8 jobs, 10 work records)
- [ ] Navigate through displays
- [ ] **Expected**: Smooth performance, quick loading
- [ ] **Status**: ___________

### Test 14.2: Cache Effectiveness
- [ ] View employer list (first time - DB query)
- [ ] View employer list again (should use cache)
- [ ] **Expected**: Second load faster than first
- [ ] **Status**: ___________

### Test 14.3: Memory Usage
- [ ] Monitor application memory usage
- [ ] Perform multiple operations
- [ ] **Expected**: Stays within 512MB limit (-Xmx512m)
- [ ] **Status**: ___________

---

## Section 15: UI/UX 🎨

### Test 15.1: Window Resizing
- [ ] Resize main window
- [ ] **Expected**: Components adjust properly
- [ ] **Status**: ___________

### Test 15.2: Menu Navigation
- [ ] Click through all menu items
- [ ] **Expected**: All menus open correct forms/displays
- [ ] **Status**: ___________

### Test 15.3: Turkish Character Support
- [ ] Enter Turkish characters: `ğ ü ş ı ö ç Ğ Ü Ş İ Ö Ç`
- [ ] Save and retrieve
- [ ] **Expected**: Characters displayed correctly
- [ ] **Status**: ___________

---

## Final Verification ✅

### Overall Application Status
- [ ] All tests passed
- [ ] No critical errors
- [ ] Database connected
- [ ] All CRUD operations working
- [ ] Payment processing functional
- [ ] Invoice generation working
- [ ] No memory leaks
- [ ] Data persists correctly

### Sign-off
- **Tester Name**: _______________________
- **Date**: _______________________
- **Result**: ☐ PASS  ☐ FAIL
- **Notes**: _______________________

---

## Quick Test Scenario (5 Minutes)

If time is limited, run this quick smoke test:

1. [ ] Login with admin/admin
2. [ ] Add one employer
3. [ ] Add one worker
4. [ ] Add one price tier
5. [ ] Add one job
6. [ ] View employers list
7. [ ] View workers list
8. [ ] View jobs list
9. [ ] Record one work entry
10. [ ] Process one payment

**If all 10 steps work, application is functional!**

---

**Testing Complete!** 🎉

If all sections passed, the application is **perfectly workable** and ready for production use!
