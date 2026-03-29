pipeline {
    agent any

    environment {
        IMAGE_NAME = "rajatrokde/node-app-devops"
        CONTAINER_NAME = "node-app-container"
    }

    tools {
        nodejs "node18"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/rajatrokde/node-app-devops.git'
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

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }
}
