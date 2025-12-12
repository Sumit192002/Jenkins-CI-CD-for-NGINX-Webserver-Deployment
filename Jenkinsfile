pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Sumit192002/Jenkins-CI-CD-for-NGINX-Webserver-Deployment.git', credentialsId: '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'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using Buildx
                    sh 'docker buildx build --tag my-nginx-image .'
                }
            }
        }
        stage('Deploy to Docker') {
            steps {
                script {
                    // Stop and remove existing Docker container using port 8085
                    sh 'docker stop $(docker ps -q --filter "publish=8086") || true'
                    sh 'docker rm $(docker ps -aq --filter "publish=8086") || true'
                    
                    // Run the Docker container on port 8085
                    sh 'docker run -d -p 8086:80 my-nginx-image'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful'
        }
        failure {
            echo 'Deployment Failed'
        }
    }
}
