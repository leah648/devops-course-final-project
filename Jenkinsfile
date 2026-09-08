pipeline {
    agent any

    environment {
        IMAGE = "leahm90/hello-world"
        TAG = "v1"
        CREDENTIALS_ID = 'dockerhub-creds'
        PATH = "C:\\Users\\user\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin;${env.PATH}"
    }


    stages {

        stage('Build') {
            steps {
                echo 'Building Docker image'
                bat 'docker build -t %IMAGE%:%TAG% .'
            }
        }

        stage('Smoke Test') {
            steps {
                echo 'Running smoke test'

                bat '''
                    docker run -d --name hello-smoke -p 5000:5000 %IMAGE%:%TAG%
                    powershell -Command "Start-Sleep -Seconds 5"
                    curl -f http://localhost:5000/health
                    docker stop hello-smoke
                    docker rm hello-smoke
                '''
            }
        }

        stage('Publish') {
            steps {
                echo 'Pushing Docker image to Docker Hub'

                withCredentials([
                    usernamePassword(
                        credentialsId: "${CREDENTIALS_ID}",
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker push %IMAGE%:%TAG%'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying application to Kubernetes'

                bat 'kubectl apply -f k8s/deployment.yaml'
                bat 'kubectl apply -f k8s/service.yaml'
            }
        }
    }

    post {
        always {
            bat 'docker image ls'
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}