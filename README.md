# OessonProject CI/CD Pipeline

## Project Overview

This project demonstrates a full CI/CD pipeline for a Node.js microservice using Jenkins, Docker, and Kubernetes.

## Steps Completed

1. **Project Setup**

   - Node.js microservice with Express.
   - Basic Jest test added.

2. **Jenkins Setup**

   - Jenkins deployed via Docker Compose.
   - Jenkins runs on [http://localhost:8083](http://localhost:8083).
   - Jenkins data is persisted using a Docker volume.

3. **Jenkins Pipeline**

   - Declarative Jenkinsfile at the project root.
   - Pipeline stages:
     1. Checkout code from GitHub.
     2. Run unit tests with `npm test`.
     3. Build Docker image.
     4. Push image to DockerHub.
     5. Deploy to Kubernetes using `kubectl apply -f`.

4. **Credentials**

   - DockerHub and Kubernetes credentials stored as Jenkins secrets.

5. **.gitignore**
   - Ignores `.terraform/`, `terraform.tfstate`, and `terraform.tfstate.backup`.

## Usage

- **Start Jenkins:**
  ```sh
  cd jenkins-docker
  docker-compose up -d
  ```
