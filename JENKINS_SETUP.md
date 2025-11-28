# Jenkins CI/CD Setup Guide

## Overview
This project is configured for automated testing and deployment through Jenkins using a declarative pipeline.

## Test Coverage
The test suite includes:
- **DAOIntegrationTest.java**: 7 integration tests validating database operations
  - Connection management and reusability
  - Admin table record presence  
  - DAO list operations for Employer, Worker, and Job entities
  - Required tables existence validation
  
- **SimpleDBTest.java**: 1 database connectivity test
  - Verifies connection to PostgreSQL database
  - Validates admin record presence

**Total**: 8 tests (all passing)

## Jenkins Pipeline Stages

1. **Checkout**: Retrieves code from Git repository
2. **Load Credentials**: Loads DB credentials from Jenkins (optional fallback to defaults)
3. **Build & Test**: Compiles code and runs JUnit tests with system properties
4. **Archive Artifacts**: Stores generated JAR files
5. **Publish HTML Report**: Publishes test results as HTML

## Required Jenkins Credentials

Configure these credentials in Jenkins (Manage Jenkins → Credentials):

| Credential ID | Type | Description | Default Fallback |
|--------------|------|-------------|------------------|
| `hesap-db-url` | Secret text | Database URL | `jdbc:postgresql://localhost:5432/hesap` |
| `hesap-db-user` | Secret text | Database username | `Hesap-User` |
| `hesap-db-password` | Secret text | Database password | `.hesap123` |

## Jenkins Setup Steps

### 1. Install Required Plugins
- Pipeline
- JUnit
- HTML Publisher  
- Git

### 2. Configure JDK
- Go to **Manage Jenkins** → **Tools**
- Add **JDK Installation**: Name = `JDK-23`, set JAVA_HOME or auto-install JDK 23

### 3. Create Pipeline Job
- Click **New Item** → enter name → select **Pipeline**
- Under **Pipeline**:
  - Definition: **Pipeline script from SCM**
  - SCM: **Git**
  - Repository URL: `https://github.com/ANIS151993/Testing-of-EWRS.git`
  - Branch: `*/main`
  - Script Path: `Jenkinsfile`

### 4. Configure Build Triggers (Optional)
- **Poll SCM**: `H/15 * * * *` (checks every 15 minutes)
- **GitHub hook trigger** (requires webhook setup)

### 5. First Run
- Click **Build Now**
- Check **Console Output** for detailed logs
- View **Test Results** and **Unit Test Report** after completion

## Test Execution Details

### Gradle Test Task
The test task passes these system properties:
```gradle
-DDB_URL=${DB_URL}
-DDB_USER=${DB_USER}  
-DDB_PASSWORD=${DB_PASSWORD}
-DTEST_MODE=true
-Djava.awt.headless=true
```

### Local Test Execution
```powershell
# Windows
$env:JAVA_HOME = "C:\Program Files\Java\jdk-23"
.\gradlew.bat clean test

# Unix/Linux/Mac
export JAVA_HOME=/path/to/jdk-23
./gradlew clean test
```

## Test Reports

After test execution, reports are available at:
- **JUnit XML**: `build/test-results/test/*.xml`
- **HTML Report**: `build/reports/tests/test/index.html`

## Refactoring Safety

The test suite provides safety guards for:
- **Database connectivity**: Ensures DB operations work across changes
- **DAO operations**: Validates list, connection reuse, and table access
- **Schema validation**: Confirms all required tables exist

When refactoring:
1. Run tests before changes: `.\gradlew.bat test`
2. Make incremental changes
3. Run tests after each change
4. Commit only when all tests pass
5. Let Jenkins validate on push

## Troubleshooting

### Tests Fail in Jenkins
- Check **Console Output** for stack traces
- Verify DB credentials are configured
- Ensure PostgreSQL is accessible from Jenkins agent
- Check JAVA_HOME is set to JDK 23

### Build Fails to Start
- Verify `Jenkinsfile` syntax
- Check JDK installation in Jenkins
- Ensure Gradle wrapper (`gradlew.bat`) has execute permissions

### Database Connection Errors
- Verify PostgreSQL is running
- Check database exists: `Hesap-eProject`
- Verify user credentials have access
- Check network connectivity to DB server

## Next Steps

1. ✅ Tests configured and passing locally
2. ✅ Jenkinsfile updated with proper DB property passing
3. ✅ Build.gradle configured to accept system properties
4. 🔄 **Configure Jenkins credentials and run pipeline**
5. 📊 Monitor test results and expand coverage as needed

## Maintenance

- Review test failures promptly
- Keep test database schema synchronized
- Update test data as business logic evolves
- Add new tests when adding features
- Monitor test execution time and optimize if needed
