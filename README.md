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

Edit k8s/deployment.yaml to point image to your image repository (for example your-dockerhub-username/hello-flask:latest) then:

  kubectl apply -f k8s/deployment.yaml
  kubectl apply -f k8s/service.yaml

Jenkinsfile

- Update environment.IMAGE and CREDENTIALS_ID to your Docker Hub repository and Jenkins credentials ID.
- To enable automatic push set the pipeline environment variable DOCKERHUB_PUSH=true.
- The pipeline builds the image, runs a smoke test against /health, and (when enabled) logs in and pushes the image.

License: MIT
