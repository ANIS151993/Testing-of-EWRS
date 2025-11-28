// Jenkinsfile v2025-11-27-1
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

    stage('Load Credentials (optional)') {
      steps {
        withCredentials([
          string(credentialsId: 'hesap-db-url',      variable: 'DB_URL_CRED'),
          string(credentialsId: 'hesap-db-user',     variable: 'DB_USER_CRED'),
          string(credentialsId: 'hesap-db-password', variable: 'DB_PASS_CRED')
        ]) {
          script {
            env.DB_URL      = (env.DB_URL_CRED  ?: env.DB_URL_DEFAULT)
            env.DB_USER     = (env.DB_USER_CRED ?: env.DB_USER_DEFAULT)
            env.DB_PASSWORD = (env.DB_PASS_CRED ?: env.DB_PASS_DEFAULT)
          }
        }
      }
    }

    stage('Build & Test') {
      steps {
        script {
          if (isUnix()) {
            sh 'chmod +x gradlew || true'
            sh """
              ./gradlew clean test build --no-daemon \\
                -DDB_URL=\${DB_URL} \\
                -DDB_USER=\${DB_USER} \\
                -DDB_PASSWORD=\${DB_PASSWORD} \\
                -DTEST_MODE=true \\
                -Djava.awt.headless=true
            """
          } else {
            bat """
              gradlew.bat clean test build --no-daemon ^
                -DDB_URL=%DB_URL% ^
                -DDB_USER=%DB_USER% ^
                -DDB_PASSWORD=%DB_PASSWORD% ^
                -DTEST_MODE=true ^
                -Djava.awt.headless=true
            """
          }
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
        archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true, onlyIfSuccessful: true
      }
    }

    stage('Publish HTML Report') {
      when { expression { fileExists('build/reports/tests/test/index.html') } }
      steps {
        publishHTML([
          reportDir: 'build/reports/tests/test',
          reportFiles: 'index.html',
          reportName: 'Unit Test Report',
          keepAll: true,
          alwaysLinkToLastBuild: true,
          allowMissing: true
        ])
      }
    }
  }

  post {
    success { echo 'Build OK' }
    failure { echo 'Build failed' }
  }
}
