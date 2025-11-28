pipeline {
    agent any
    
    tools {
        jdk 'JDK-23'  // Configure in Jenkins: Manage Jenkins > Tools > JDK installations
    }
    
    environment {
        DB_URL = credentials('hesap-db-url') ?: 'jdbc:postgresql://localhost:5432/Hesap-eProject'
        DB_USER = credentials('hesap-db-user') ?: 'Hesap-eProject'
        DB_PASSWORD = credentials('hesap-db-password') ?: '.hesap-eProject.'
        TEST_MODE = 'true'
        CI = 'true'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh './gradlew clean build -x test'
                    } else {
                        bat 'gradlew.bat clean build -x test'
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh './gradlew test'
                    } else {
                        bat 'gradlew.bat test'
                    }
                }
            }
            post {
                always {
                    junit '**/build/test-results/test/*.xml'
                    publishHTML([
                        reportDir: 'build/reports/tests/test',
                        reportFiles: 'index.html',
                        reportName: 'Test Report',
                        keepAll: true
                    ])
                }
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build and tests completed successfully!'
        }
        failure {
            echo 'Build or tests failed. Check the logs for details.'
        }
    }
}

// v2025-11-27-2

// v2025-11-27-2
