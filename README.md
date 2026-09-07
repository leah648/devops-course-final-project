# Hello World - CI/CD & GitOps Pipeline

A simple Flask application deployed to Kubernetes through an automated Jenkins CI/CD pipeline.

**Tech Stack:** Flask · Docker · Docker Hub · Jenkins · Kubernetes · GitHub

---

## 📁 Project Structure

```text
.
├── app/
│   ├── app.py
│   └── requirements.txt
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── Dockerfile
├── Jenkinsfile
└── README.md
```

---

## 🚀 Application

The application is built with Flask and provides:

| Endpoint  | Description     |
| --------- | --------------- |
| `/`       | Hello World     |
| `/health` | Health check    |
| `/ready`  | Readiness check |

---

## 🐳 Docker

### Build

```bash
docker build -t hello-world:v1 .
```

### Run

```bash
docker run -p 5000:5000 hello-world:v1
```

Open `http://localhost:5000` in your browser.

### Push to Docker Hub

```bash
docker tag hello-world:v1 leahm90/hello-world:v1
docker login
docker push leahm90/hello-world:v1
```

---

## ☸️ Kubernetes

The application is deployed using a Kubernetes **Deployment** and **NodePort Service**.

### Deployment

The Deployment includes:

* **2 replicas**
* CPU and memory **requests**
* CPU and memory **limits**

### Deploy

```bash
minikube start --driver=docker

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### Verify

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

### Access the Application

```bash
minikube service hello-world-service
```

---

## 🔄 Jenkins CI/CD

The CI/CD pipeline is defined in the `Jenkinsfile`.

```text
GitHub
   │
   ▼
Jenkins
   │
   ├── Build
   ├── Smoke Test
   ├── Build Docker Image
   ├── Push to Docker Hub
   └── Deploy to Kubernetes
          │
          ▼
     Running Pods
          │
          ▼
      Hello World
```

### Pipeline Stages

| Stage          | Action                               |
| -------------- | ------------------------------------ |
| **Build**      | Build the Docker image               |
| **Smoke Test** | Verify application health            |
| **Publish**    | Push the image to Docker Hub         |
| **Deploy**     | Deploy the application to Kubernetes |

### Jenkins Pipeline Screenshot

*Add a screenshot of a successful Jenkins pipeline here.*

---

## 🔧 Prerequisites

* Python
* Git
* Docker Desktop
* Minikube
* kubectl
* Jenkins

---

## 🛠️ Troubleshooting

### Check Pod Status

```bash
kubectl get pods
```

### Check Pod Logs

```bash
kubectl logs <pod-name>
```

### Check Service

```bash
kubectl get service hello-world-service
```

### Check Minikube Status

```bash
minikube status
```

### Restart Minikube

```bash
minikube stop
minikube start --driver=docker
```

---

## 🎯 Project Goal

This project demonstrates an end-to-end DevOps workflow:

**Source Control → CI/CD → Containerization → Docker Registry → Kubernetes Deployment**
