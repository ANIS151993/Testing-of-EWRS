# How to Run the Application

## Problem: "Could not find or load main class"

This error occurs when trying to run `.java` source files directly. Java requires compiled `.class` files.

## ✅ Solutions (Pick One)

### Solution 1: Double-Click Run Script (EASIEST)
1. Navigate to the project folder in File Explorer
2. Double-click `run-app.bat`
3. The application will compile and start automatically

### Solution 2: Command Line with Gradle
```cmd
cd C:\Users\engra\Downloads\employer-worker-registration-system-main
run-app.bat
```

Or use Gradle directly:
```powershell
.\gradle-run.bat run
```

### Solution 3: VS Code (Recommended for Development)

**First Time Setup:**
1. Open the project folder in VS Code
2. Install "Extension Pack for Java" if not installed
3. Wait for Java extension to load the project

**To Run:**
- Press `F5` (or click Run → Start Debugging)
- Or press `Ctrl+F5` (Run without debugging)
- Or click the "Run" button above `main()` method in `Main.java`

**Available VS Code Tasks:**
- `Ctrl+Shift+B` → Build (default)
- Terminal → Run Task → "runApp", "cleanBuild", or "test"

### Solution 4: Manual Compilation and Run

**Step 1: Compile with Gradle**
```powershell
.\gradle-run.bat build
```

**Step 2: Run the compiled application**
```powershell
java -cp "build\classes\java\main;%USERPROFILE%\.gradle\caches\modules-2\files-2.1\org.postgresql\postgresql\42.7.4\f4d55ac35dcbe061c19a1b6f6e45fbd981f0e656\postgresql-42.7.4.jar" com.cbozan.main.Main
```

## Why Did the Original Command Fail?

**Your command:**
```powershell
java -cp 'src' com.cbozan.main.Main
```

**Problems:**
1. ❌ Classpath points to `src` (source files) instead of `build/classes/java/main` (compiled files)
2. ❌ Source files (`.java`) cannot be executed directly - they must be compiled to `.class` files first
3. ❌ PostgreSQL driver dependency is missing from classpath

**Correct approach:**
1. ✅ First compile: `.\gradle-run.bat build`
2. ✅ Then run: `.\gradle-run.bat run` (or use `run-app.bat`)

## File Locations

- **Source files**: `src/com/cbozan/.../*.java`
- **Compiled classes**: `build/classes/java/main/com/cbozan/.../*.class`
- **JAR file**: `build/libs/employer-worker-registration-system-1.0.0.jar`
- **Dependencies**: Managed by Gradle in `~/.gradle/caches/`

## Build System Architecture

```
Source Code (src/)
    ↓
Gradle Build (./gradlew build)
    ↓
Compiled Classes (build/classes/java/main/)
    ↓
Run Application (./gradlew run)
```

## Troubleshooting

**"JAVA_HOME is not set"**
- Use `run-app.bat` or `gradle-run.bat` (auto-sets JAVA_HOME)
- Or set manually: See README.md "Java runtime" section

**"BUILD FAILED"**
```powershell
.\gradle-run.bat clean build
```

**Application won't start from VS Code**
1. Open Command Palette (`Ctrl+Shift+P`)
2. Run "Java: Clean Java Language Server Workspace"
3. Reload VS Code
4. Try running again

**Want to create a standalone executable?**
```powershell
.\gradle-run.bat jar
java -jar build\libs\employer-worker-registration-system-1.0.0.jar
```

## Summary

✅ **Never run from `src` folder** - source files cannot be executed  
✅ **Always compile first** - use Gradle to build  
✅ **Easiest method** - use `run-app.bat`  
✅ **Best for development** - use VS Code with F5  
✅ **Most control** - use Gradle wrapper directly  
