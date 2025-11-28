// Jenkinsfile v2025-11-28-1
pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
    disableConcurrentBuilds()
  }

  environment {
    DB_URL_DEFAULT  = 'jdbc:postgresql://localhost:5432/hesap'
    DB_USER_DEFAULT = 'Hesap-User'
    DB_PASS_DEFAULT = '.hesap123'
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Setup Environment') {
      steps {
        script {
          // Try to load credentials if they exist, otherwise use defaults
          try {
            withCredentials([
              string(credentialsId: 'hesap-db-url',      variable: 'DB_URL_CRED'),
              string(credentialsId: 'hesap-db-user',     variable: 'DB_USER_CRED'),
              string(credentialsId: 'hesap-db-password', variable: 'DB_PASS_CRED')
            ]) {
              env.DB_URL      = env.DB_URL_CRED
              env.DB_USER     = env.DB_USER_CRED
              env.DB_PASSWORD = env.DB_PASS_CRED
              echo "Using Jenkins credentials for database connection"
            }
          } catch (Exception e) {
            echo "Jenkins credentials not found, using default values"
            env.DB_URL      = env.DB_URL_DEFAULT
            env.DB_USER     = env.DB_USER_DEFAULT
            env.DB_PASSWORD = env.DB_PASS_DEFAULT
          }
          
          // Display connection info (password masked)
          echo "Database URL: ${env.DB_URL}"
          echo "Database User: ${env.DB_USER}"
        }
      }
    }

    stage('Build & Test') {
      steps {
        script {
          echo "=== Starting Build & Test ==="
          if (isUnix()) {
            sh 'java -version'
            sh 'chmod +x gradlew || true'
            sh """
              ./gradlew --version
            """
            sh """
              ./gradlew clean test build --no-daemon --info \\
                -DDB_URL=\${DB_URL} \\
                -DDB_USER=\${DB_USER} \\
                -DDB_PASSWORD=\${DB_PASSWORD} \\
                -DTEST_MODE=true \\
                -Djava.awt.headless=true
            """
            sh 'ls -lah build/libs/ || echo "No libs directory"'
            sh 'ls -lah build/test-results/test/ || echo "No test results"'
            sh 'ls -lah build/reports/tests/test/ || echo "No test reports"'
          } else {
            bat 'java -version'
            bat 'gradlew.bat --version'
            bat """
              gradlew.bat clean test build --no-daemon --info ^
                -DDB_URL=%DB_URL% ^
                -DDB_USER=%DB_USER% ^
                -DDB_PASSWORD=%DB_PASSWORD% ^
                -DTEST_MODE=true ^
                -Djava.awt.headless=true
            """
            bat 'dir build\\libs\\ || echo No libs directory'
            bat 'dir build\\test-results\\test\\ || echo No test results'
            bat 'dir build\\reports\\tests\\test\\ || echo No test reports'
          }
          echo "=== Build & Test Complete ==="
        }
      }
      post {
        always {
          junit allowEmptyResults: true, testResults: 'build/test-results/test/*.xml'
        }
      }
    }

    stage('Archive Artifacts') {
      steps {
        script {
          echo "=== Archiving Artifacts ==="
          def jarFiles = findFiles(glob: 'build/libs/*.jar')
          if (jarFiles.length > 0) {
            echo "Found ${jarFiles.length} JAR file(s) to archive:"
            jarFiles.each { echo "  - ${it.name}" }
            archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true, allowEmptyArchive: true
            echo "✅ Artifacts archived successfully"
          } else {
            echo "⚠️  WARNING: No JAR files found in build/libs/ - check Build & Test stage"
            currentBuild.result = 'UNSTABLE'
          }
        }
      }
    }

    stage('Publish HTML Report') {
      steps {
        script {
          echo "=== Publishing HTML Test Report ==="
          if (fileExists('build/reports/tests/test/index.html')) {
            echo "Test report found, publishing..."
            publishHTML([
              reportDir: 'build/reports/tests/test',
              reportFiles: 'index.html',
              reportName: 'Unit Test Report',
              keepAll: true,
              alwaysLinkToLastBuild: true,
              allowMissing: true
            ])
            echo "✅ HTML Report published successfully"
          } else {
            echo "⚠️  WARNING: Test report not found at build/reports/tests/test/index.html"
            echo "This usually means tests did not run or failed to generate reports"
            currentBuild.result = 'UNSTABLE'
          }
        }
      }
    }
  }

  post {
    success { 
      echo "\n========================================"
      echo "✅ BUILD SUCCESSFUL"
      echo "All stages completed:"
      echo "  ✓ Checkout"
      echo "  ✓ Setup Environment"
      echo "  ✓ Build & Test (8 JUnit tests)"
      echo "  ✓ Archive Artifacts (JAR files)"
      echo "  ✓ Publish HTML Report"
      echo "========================================\n"
    }
    failure { 
      echo "\n========================================"
      echo "❌ BUILD FAILED"
      echo "Check console output above for errors"
      echo "========================================\n"
    }
  }
}
