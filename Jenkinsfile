pipeline {
    agent any

    environment {
        IMAGE = 'leahm90/hello-world'
        TAG = 'v1'
        CREDENTIALS_ID = 'dockerhub-creds'
    }

    stages {
        stage('Clone') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            if [ -d .git ]; then
                                echo "Repository already available in workspace"
                            else
                                git clone https://github.com/leah648/devops-course-final-project.git .
                            fi
                        '''
                    } else {
                        bat '''
                            if exist .git (
                                echo Repository already available in workspace
                            ) else (
                                git clone https://github.com/leah648/devops-course-final-project.git .
                            )
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'docker build -t "$IMAGE:$TAG" .'
                    } else {
                        bat 'docker build -t %IMAGE%:%TAG% .'
                    }
                }
            }
        }

        stage('Smoke Test') {
            steps {
                echo 'Running smoke test'
                script {
                    if (isUnix()) {
                        sh '''
                            docker run -d --name hello-smoke -p 5000:5000 "$IMAGE:$TAG"
                            sleep 5
                            curl -f http://localhost:5000/health
                            docker stop hello-smoke
                            docker rm hello-smoke
                        '''
                    } else {
                        bat '''
                            docker run -d --name hello-smoke -p 5000:5000 %IMAGE%:%TAG%
                            powershell -Command "Start-Sleep -Seconds 5"
                            curl -f http://localhost:5000/health
                            docker stop hello-smoke
                            docker rm hello-smoke
                        '''
                    }
                }
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Scanning Docker image for CRITICAL vulnerabilities'
                script {
                    if (isUnix()) {
                        sh 'trivy image --severity CRITICAL --exit-code 1 "$IMAGE:$TAG"'
                    } else {
                        bat 'trivy image --severity CRITICAL --exit-code 1 %IMAGE%:%TAG%'
                    }
                }
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
                    script {
                        if (isUnix()) {
                            sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                            sh 'docker push "$IMAGE:$TAG"'
                        } else {
                            bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                            bat 'docker push %IMAGE%:%TAG%'
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying application to Kubernetes'
                script {
                    if (isUnix()) {
                        sh 'kubectl apply -f k8s/deployment.yaml'
                        sh 'kubectl apply -f k8s/service.yaml'
                    } else {
                        bat 'kubectl apply -f k8s/deployment.yaml'
                        bat 'kubectl apply -f k8s/service.yaml'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                if (isUnix()) {
                    sh 'docker image ls'
                } else {
                    bat 'docker image ls'
                }
            }
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}

