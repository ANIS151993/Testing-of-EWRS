Jenkins Test

# Testing-of-EWRS
Jenkins Test

## Java Version Requirement

**This project requires JDK 23** for both local development and Jenkins CI builds. The Gradle build is configured to use Java 23 via the toolchain block:

```gradle
java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(23)
	}
}
```

**Jenkins Setup:**
- Ensure JDK 23 is installed on your Jenkins build agent.
- In Jenkins, go to "Manage Jenkins" > "Global Tool Configuration" and add JDK 23.
- Set JDK 23 as the default for this job, or specify it in the pipeline/job configuration.

If JDK 23 is not available, the build will fail with a toolchain error.
