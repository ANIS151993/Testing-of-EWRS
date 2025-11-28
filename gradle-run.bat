@echo off
REM Set JAVA_HOME for this session
SET JAVA_HOME=C:\Program Files\Java\jdk-23
SET PATH=%JAVA_HOME%\bin;%PATH%

REM Verify Java is available
echo Checking Java installation...
java -version
echo.

REM Run Gradle wrapper with all arguments
echo Running Gradle wrapper...
gradlew.bat %*
