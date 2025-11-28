# Gradle Build - Quick Reference

## Prerequisites
- JDK 23 installed at: `C:\Program Files\Java\jdk-23`
- JAVA_HOME environment variable set (see README.md)

## Common Commands

### Option 1: Use the helper batch file (sets JAVA_HOME automatically)
```cmd
gradle-run.bat build          # Build the project
gradle-run.bat run            # Run the application
gradle-run.bat test           # Run tests
gradle-run.bat clean          # Clean build artifacts
gradle-run.bat jar            # Create executable jar
```

### Option 2: Use gradlew directly (requires JAVA_HOME to be set)
```powershell
.\gradlew.bat build
.\gradlew.bat run
.\gradlew.bat test
.\gradlew.bat clean
```

### Set JAVA_HOME for current PowerShell session:
```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-23"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
```

## Build Output
- Compiled classes: `build/classes/java/main/`
- JAR file: `build/libs/employer-worker-registration-system-1.0.0.jar`
- Test reports: `build/reports/tests/test/index.html`

## Dependencies
- PostgreSQL JDBC Driver: 42.7.4 (managed by Gradle)
- JUnit Jupiter: 5.10.0 (for testing)

## Troubleshooting

**Error: "JAVA_HOME is set to an invalid directory"**
- Solution: Set JAVA_HOME permanently in System Environment Variables or use `gradle-run.bat`

**Error: "Cannot find a Java installation matching requirements"**
- Solution: Ensure JDK 23 is installed and JAVA_HOME points to it

**Build fails with "class file major version" error**
- Solution: Clean Gradle cache and rebuild:
  ```powershell
  Remove-Item "$env:USERPROFILE\.gradle\caches" -Recurse -Force
  .\gradlew.bat clean build --refresh-dependencies
  ```
