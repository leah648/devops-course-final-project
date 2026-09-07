# Hello World - CI/CD & GitOps Pipeline

## Overview

This project demonstrates a complete CI/CD pipeline for building, containerizing, and deploying a simple Hello World web application to Kubernetes.

The project uses Flask, Docker, Docker Hub, Kubernetes, and Jenkins.

## Project Structure

```text
.
├── app/
│   └── app.py
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── Dockerfile
├── Jenkinsfile
└── README.md
Application

The application is a simple Flask web application that displays:

Hello World
Prerequisites

The following tools are required:

Python
Docker Desktop
Minikube
kubectl
Jenkins
Git
Run the Application Locally

Run:

python app/app.py

The application will be available at:

http://localhost:5000
Docker
Build the Docker Image
docker build -t hello-world:v1 .
Run the Container
docker run -p 5000:5000 hello-world:v1

The application can then be accessed at:

http://localhost:5000
Push the Image to Docker Hub

Tag the image:

docker tag hello-world:v1 leahm90/hello-world:v1

Login to Docker Hub:

docker login

Push the image:

docker push leahm90/hello-world:v1
Kubernetes

The application is deployed to Kubernetes using a Deployment and a Service.

The Deployment is configured with:

2 replicas
CPU and memory requests
CPU and memory limits

The Service uses NodePort to expose the application.

Start Minikube
minikube start --driver=docker
Deploy the Application

Apply the Deployment:

kubectl apply -f k8s/deployment.yaml

Apply the Service:

kubectl apply -f k8s/service.yaml
Verify the Deployment

Check the Deployment:

kubectl get deployments

Check the Pods:

kubectl get pods

Check the Service:

kubectl get services

The application should have two running Pods.

Access the Application

Run:

minikube service hello-world-service

This opens the Hello World application through the Kubernetes Service.

Jenkins CI/CD Pipeline

The CI/CD pipeline is defined in the Jenkinsfile.

The pipeline consists of the following stages:

Build Application
Build Docker Image
Push Docker Image to Docker Hub
Deploy to Kubernetes

The goal is to automate the process from source code to a running Kubernetes deployment.

GitOps

The Kubernetes configuration is stored as code in the GitHub repository under the k8s/ directory.

Changes to the Kubernetes configuration can therefore be version-controlled and tracked through Git.

Troubleshooting
Check Pod Status
kubectl get pods
Check Pod Logs
kubectl logs <pod-name>
Check Service
kubectl get service hello-world-service
Check Minikube Status
minikube status
Restart Minikube
minikube stop
minikube start --driver=docker
Jenkins Pipeline Screenshot

A screenshot of a successful Jenkins pipeline execution will be added here after the Jenkins pipeline is configured and executed successfully.

Conclusion

This project demonstrates a complete workflow for:

GitHub
   ↓
Jenkins
   ↓
Build
   ↓
Docker Image
   ↓
Docker Hub
   ↓
Kubernetes
   ↓
Ru