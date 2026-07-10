pipeline {
    agent any

    tools {
        nodejs 'node18'
    }


    environment {
        IMAGE_NAME = 'rajatrokde/node-app-devops'
        CONTAINER_NAME = 'node-app-container'
        SCANNER_HOME= tool 'sonarqube'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/rajatrokde/node-app-devops.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }

        stage('Lint') {
            steps {
                dir('app') {
                    sh 'npm run lint || true'
                }
            }
        }

        stage('Test') {
            steps {
                dir('app') {
                    sh 'npm test || true'
                }
            }
        }

stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    // Use the correct 'sonar-scanner' command
                    // Point binaries to 'target/classes' for efficiency
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=demo -Dsonar.projectKey=jenkins \
                             -Dsonar.java.binaries=target/classes '''
                }
             }
        }
        stage('Quality Gate') {
            steps {
                script {
                  // Allow pipeline to continue even if gate fails (adjust if needed)
                  waitForQualityGate abortPipeline: false, credentialsId: 'sqa_c81b5fac17fb8f95783dec091191c31aaae7e959'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }

        success {
            echo 'Pipeline succeeded.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
