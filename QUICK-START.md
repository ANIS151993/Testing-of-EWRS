# 🚀 QUICK START - Employer-Worker Registration System

## Run the Application (Choose One)

### 🎯 Easiest: Double-Click
```
📁 Find in File Explorer:
   run-app.bat

🖱️ Double-click it
```

### 💻 Command Line
```cmd
run-app.bat
```

### 🔧 VS Code
```
Press F5
```

### ⚙️ Gradle
```powershell
.\gradlew.bat run
```

---

## Common Tasks

| Task | Command |
|------|---------|
| **Run App** | `run-app.bat` or `.\gradlew.bat run` |
| **Build** | `.\gradle-run.bat build` |
| **Clean Build** | `.\gradle-run.bat clean build` |
| **Run Tests** | `.\gradle-run.bat test` |
| **Create JAR** | `.\gradle-run.bat jar` |

---

## Files You Need to Know

| File | Purpose |
|------|---------|
| `run-app.bat` | 🎯 Click to run (easiest) |
| `gradle-run.bat` | Helper for Gradle commands |
| `HOW-TO-RUN.md` | Complete how-to guide |
| `GRADLE-GUIDE.md` | All Gradle commands |
| `SOLUTION-SUMMARY.md` | What was fixed |

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Cannot find main class" | Use `run-app.bat` instead of running from src |
| "JAVA_HOME not set" | Use `run-app.bat` (auto-sets it) |
| "Build failed" | Run `.\gradle-run.bat clean build` |
| App won't start | Check PostgreSQL database is set up |

---

## Project Structure

```
📁 Project Root
├── 🚀 run-app.bat          ← Double-click this!
├── ⚙️ gradle-run.bat       ← Helper for Gradle
├── 📖 HOW-TO-RUN.md        ← Read this for details
├── 📁 src/                 ← Source code
└── 📁 build/               ← Compiled files (auto-generated)
```

---

## Need Help?

1. Read `HOW-TO-RUN.md` for detailed instructions
2. Check `GRADLE-GUIDE.md` for Gradle commands
3. See `SOLUTION-SUMMARY.md` for what was fixed

---

**Remember:** Always use `run-app.bat` or Gradle to run the app.  
Never try to run `.java` files directly!

✅ **Status: Everything is working perfectly!**
