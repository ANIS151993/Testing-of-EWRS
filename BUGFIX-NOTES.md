# Bugfix Notes: Menus not working after Login

Date: 2025-11-05

## Symptoms
- After a successful Login, the Main window shows a blank content area.
- Clicking menu items (Record, Add, Display) appears to do nothing.
- Launch ran with a configuration that used the raw `src` folder as the classpath, bypassing Gradle and dependencies.

## Root Causes
1. VS Code had an extra launch configuration named "Main" that used `projectName: "src"` and the `src` folder on the classpath. This skips the Gradle build and does not include dependencies (e.g., PostgreSQL JDBC).
2. When dependencies are missing, DAO constructors can fail during panel creation, preventing the panels from being attached to the frame, which leaves the content area blank.
3. DB connection previously returned `null` on failure, which could surface as `NullPointerException` in DAOs.

## Fixes Applied
- Removed the broken VS Code launch entry and kept a single, correct config that builds via Gradle and launches with the compiled classes and dependencies.
- Hardened `DB.getConnection()` so it never returns `null`. If the database is unavailable, it now returns a no-op `Connection` that throws `SQLException` on usage; DAOs already catch `SQLException`, so the UI can render with empty lists instead of crashing.

## How to Run
- Use the "Launch Main" configuration in VS Code (F5). It will build with Gradle first.
- Or run from terminal:
  - `./gradlew.bat clean build --no-daemon`
  - `./gradlew.bat run --no-daemon`

## Notes
- If PostgreSQL is not running or the database is not created, panels will load but lists will be empty; an error dialog will appear when DAOs query.
- See `DATABASE-SETUP.md` to configure the database.
