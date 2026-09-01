pipeline {
  agent any
  environment {
    IMAGE = "your-dockerhub-username/hello-flask"
    TAG = "${env.BUILD_NUMBER ?: 'latest'}"
    CREDENTIALS_ID = 'dockerhub-creds' // update this to your Jenkins credentials id
  }
  stages {
    stage('Build') {
      steps {
        echo 'Building Docker image'
        sh 'docker build -t ${IMAGE}:${TAG} .'
      }
    }
    stage('Smoke Test') {
      steps {
        echo 'Running smoke test'
        sh '''
          docker run -d --name hello-smoke -p 5000:5000 ${IMAGE}:${TAG}
          # wait for app to start
          for i in {1..10}; do
            if curl -sSf http://localhost:5000/health; then break; fi
            sleep 1
          done
          docker stop hello-smoke || true
        '''
      }
    }
    stage('Publish') {
      when {
        expression { return env.DOCKERHUB_PUSH == 'true' }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: "${CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh 'docker push ${IMAGE}:${TAG}'
        }
      }
    }
  }
  post {
    always {
      sh 'docker image ls | head -n 20 || true'
    }
  }
}
