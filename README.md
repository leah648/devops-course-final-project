# Hello Flask (Hello World)

Simple Flask "Hello World" application packaged for Docker and Kubernetes.

Repository layout:
```
.
├── app/
│   ├── app.py
│   └── requirements.txt
├── Dockerfile
├── Jenkinsfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── README.md
```

Features
- Flask app with endpoints:
  - / -> "Hello World"
  - /health -> health check (200)
  - /ready -> readiness check (200)
- Dockerfile producing a small image (uses gunicorn)
- Kubernetes manifests with liveness/readiness probes
- Jenkinsfile pipeline to build, smoke-test and optionally push image

Run locally (without Docker)

1. Create a virtual environment and install dependencies:

   python -m venv .venv
   .venv\Scripts\activate   # Windows
   pip install -r app\requirements.txt

2. Run the app:

   python app\app.py

The app will be available at http://localhost:5000 and will respond with "Hello World".

Build and run with Docker

1. Build the image:

   docker build -t hello-flask:latest .

2. Run the container:

   docker run -p 5000:5000 hello-flask:latest

Kubernetes

Edit k8s/deployment.yaml to point image to your image repository (already set to `leahm90/devops-course-final-project:latest`) then:

  kubectl apply -f k8s/deployment.yaml
  kubectl apply -f k8s/service.yaml

Jenkinsfile

- The pipeline default IMAGE is set to `leahm90/devops-course-final-project` and uses the Jenkins credentials id `dockerhub-creds`.
- To enable automatic push set the pipeline environment variable DOCKERHUB_PUSH=true and ensure the Jenkins credential `dockerhub-creds` contains your Docker Hub username (leahm90) and password.
- The pipeline builds the image, runs a smoke test against /health, and (when enabled) logs in and pushes the image.

Pushing code to GitHub and the Docker image

1) Push this repository to GitHub (recommended: use SSH or a personal access token):

   # using HTTPS (you will be prompted for credentials or use a PAT)
   git remote add origin https://github.com/leah648/devops-course-final-project.git
   git branch -M main
   git push -u origin main

   # or using SSH (ensure your SSH key is added to GitHub)
   git remote add origin git@github.com:leah648/devops-course-final-project.git
   git branch -M main
   git push -u origin main

2) Build and push Docker image locally (or let Jenkins push it):

   docker build -t leahm90/devops-course-final-project:latest .
   docker login --username leahm90
   # enter your Docker Hub password when prompted (do NOT store it in this repo)
   docker push leahm90/devops-course-final-project:latest

Security note: Do NOT commit passwords, tokens, or other credentials into the repository. Use Jenkins credentials store, GitHub Secrets, or your local Docker login.

License: MIT
