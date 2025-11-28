# Jenkins CI/CD Testing Guide

## Overview

This project now includes comprehensive JUnit tests and Jenkins CI/CD pipeline integration. The test suite validates database connectivity and DAO operations to safeguard against refactoring issues.

---

## ✅ Test Results Summary

**All 8 tests PASSED successfully!**

### Test Coverage

#### SimpleDBTest (1 test)
- ✅ `canConnectToExistingDatabase()` - Validates PostgreSQL connection

#### DAOIntegrationTest (7 tests)
- ✅ `dbConnectionShouldWork()` - Database connection validation
- ✅ `dbConnectionShouldBeReusable()` - Singleton pattern verification
- ✅ `adminTableShouldHaveAtLeastOneRecord()` - Admin data presence check
- ✅ `allRequiredTablesShouldExist()` - Schema validation (11 tables)
- ✅ `employerDAOShouldList()` - Employer DAO functionality
- ✅ `workerDAOShouldList()` - Worker DAO functionality
- ✅ `jobDAOShouldList()` - Job DAO functionality

---

## 🚀 Running Tests Locally

### Prerequisites
- PostgreSQL 16 running on localhost:5432
- Database `Hesap-eProject` created with schema
- JDK 23 installed

### Run All Tests
```powershell
cd 'c:\Users\engra\Downloads\employer-worker-registration-system-main'
$env:JAVA_HOME='C:\Program Files\Java\jdk-23'
.\gradlew.bat test
```

### Run Tests with Detailed Output
```powershell
.\gradlew.bat test --info
```

### Run Specific Test Class
```powershell
.\gradlew.bat test --tests SimpleDBTest
.\gradlew.bat test --tests DAOIntegrationTest
```

### View Test Reports
After running tests, open:
```
build/reports/tests/test/index.html
```

---

## 🔧 Jenkins Setup

### 1. Configure Jenkins Tools
Navigate to **Manage Jenkins** > **Tools**:

#### JDK Configuration
- Name: `JDK-23`
- JAVA_HOME: `C:\Program Files\Java\jdk-23` (Windows) or `/usr/lib/jvm/java-23` (Linux)
- Or use auto-installer for Oracle JDK 23

### 2. Configure Database Credentials
Navigate to **Manage Jenkins** > **Credentials**:

Add the following credentials:
- **ID:** `hesap-db-url`
  - **Kind:** Secret text
  - **Secret:** `jdbc:postgresql://localhost:5432/Hesap-eProject`

- **ID:** `hesap-db-user`
  - **Kind:** Secret text
  - **Secret:** `Hesap-eProject`

- **ID:** `hesap-db-password`
  - **Kind:** Secret text
  - **Secret:** `.hesap-eProject.`

### 3. Create Jenkins Pipeline Job

1. Click **New Item**
2. Enter name: `employer-worker-registration-system`
3. Select **Pipeline**
4. Under **Pipeline** section:
   - **Definition:** Pipeline script from SCM
   - **SCM:** Git
   - **Repository URL:** Your Git repository URL
   - **Branch:** `*/master` (or your branch)
   - **Script Path:** `Jenkinsfile`
5. Click **Save**

### 4. Configure PostgreSQL on Jenkins Agent

Ensure PostgreSQL is installed and accessible on the Jenkins agent:

#### Windows Agent
```powershell
# Install PostgreSQL 16
# Set up database
cd database
.\setup-database-new.ps1
```

#### Linux Agent
```bash
# Install PostgreSQL
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# Set up database
sudo -u postgres psql -c "CREATE DATABASE \"Hesap-eProject\";"
sudo -u postgres psql -c "CREATE USER \"Hesap-eProject\" WITH PASSWORD '.hesap-eProject.';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"Hesap-eProject\" TO \"Hesap-eProject\";"
```

---

## 📊 Jenkins Pipeline Stages

The `Jenkinsfile` defines the following stages:

### 1. Checkout
- Pulls latest code from Git repository

### 2. Build
- Compiles Java source code
- Excludes tests from compilation
- Command: `gradlew clean build -x test`

### 3. Test
- Runs all JUnit tests
- Generates test reports
- Publishes results to Jenkins UI
- Command: `gradlew test`

### 4. Archive
- Archives built JAR files
- Makes artifacts downloadable from Jenkins

---

## 🧪 Test Configuration

### System Properties
Tests run with the following properties:
- `TEST_MODE=true` - Suppresses GUI dialogs
- `java.awt.headless=true` - Headless mode for CI
- `DB_URL` - Database connection URL (overridable)
- `DB_USER` - Database username (overridable)
- `DB_PASSWORD` - Database password (overridable)

### Environment Variables (CI)
```groovy
environment {
    TEST_MODE = 'true'
    CI = 'true'
    DB_URL = credentials('hesap-db-url')
    DB_USER = credentials('hesap-db-user')
    DB_PASSWORD = credentials('hesap-db-password')
}
```

---

## 🔍 Test Details

### SimpleDBTest
**Purpose:** Basic database connectivity validation

**Test:** `canConnectToExistingDatabase()`
- Sets system properties for DB connection
- Gets connection from `DB.getConnection()`
- Asserts connection is not null and open
- Queries admin table to verify data access
- Validates at least 1 admin record exists

### DAOIntegrationTest
**Purpose:** Comprehensive DAO layer integration testing

**Tests:**
1. `dbConnectionShouldWork()` - Validates connection is open
2. `dbConnectionShouldBeReusable()` - Tests singleton pattern
3. `adminTableShouldHaveAtLeastOneRecord()` - Admin data validation
4. `allRequiredTablesShouldExist()` - Schema completeness check
5. `employerDAOShouldList()` - Employer DAO operations
6. `workerDAOShouldList()` - Worker DAO operations
7. `jobDAOShouldList()` - Job DAO operations

---

## 📝 Refactoring Safety

These tests protect against breaking changes during refactoring:

### DB Connection Changes
- `dbConnectionShouldWork()` catches connection failures
- `dbConnectionShouldBeReusable()` validates singleton behavior

### DAO Method Changes
- `employerDAOShouldList()` validates Employer DAO
- `workerDAOShouldList()` validates Worker DAO
- `jobDAOShouldList()` validates Job DAO

### Schema Changes
- `allRequiredTablesShouldExist()` catches missing tables
- `adminTableShouldHaveAtLeastOneRecord()` validates data presence

---

## 🐛 Troubleshooting

### Test Failure: Database Connection
**Error:** `SQLException: Cannot connect to database`

**Solutions:**
1. Verify PostgreSQL is running:
   ```powershell
   Get-Service -Name postgresql*
   ```

2. Check database exists:
   ```powershell
   & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -l
   ```

3. Run database setup:
   ```powershell
   cd database
   .\setup-database-new.ps1
   ```

### Test Failure: Admin Table Empty
**Error:** `AssertionError: Admin table should have at least 1 record`

**Solution:**
```powershell
cd database
.\setup-database-new.ps1  # Re-run setup to load sample data
```

### Jenkins Build Failure
**Error:** `JDK not configured`

**Solution:**
1. Go to **Manage Jenkins** > **Tools**
2. Add JDK installation named `JDK-23`
3. Save and re-run pipeline

---

## 📈 Continuous Integration Benefits

### Automated Testing
- Every commit triggers test suite
- Immediate feedback on breaking changes
- Test reports accessible in Jenkins UI

### Quality Assurance
- Validates database operations
- Ensures schema integrity
- Catches DAO regressions

### Deployment Safety
- Only builds with passing tests are archived
- Reduces production bugs
- Increases confidence in refactoring

---

## 🎯 Next Steps

### Add More Tests
```java
// Example: Test worker creation
@Test
void workerDAOShouldCreateWorker() {
    Worker worker = new Worker();
    worker.setName("Test Worker");
    worker.setPhone("555-1234");
    
    Worker created = WorkerDAO.getInstance().create(worker);
    assertNotNull(created);
    assertNotNull(created.getId());
}
```

### Configure Notifications
Add to `Jenkinsfile`:
```groovy
post {
    failure {
        mail to: 'team@example.com',
             subject: "Build Failed: ${env.JOB_NAME}",
             body: "Check console output at ${env.BUILD_URL}"
    }
}
```

### Add Code Coverage
Update `build.gradle`:
```gradle
plugins {
    id 'jacoco'
}

jacocoTestReport {
    reports {
        xml.required = true
        html.required = true
    }
}
```

---

## 📚 Resources

- [JUnit 5 Documentation](https://junit.org/junit5/docs/current/user-guide/)
- [Gradle Test Documentation](https://docs.gradle.org/current/userguide/java_testing.html)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/16/)

---

## ✅ Test Execution Summary

**Date:** November 27, 2025  
**Status:** ✅ ALL TESTS PASSED  
**Total Tests:** 8  
**Passed:** 8  
**Failed:** 0  
**Skipped:** 0  
**Duration:** ~4 seconds  

**Build:** ✅ SUCCESSFUL  
**Database:** ✅ CONNECTED  
**DAO Layer:** ✅ OPERATIONAL  

---

