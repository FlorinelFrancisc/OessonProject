# OessonProject CI/CD & Monitoring

## Project Overview

This project demonstrates a full CI/CD pipeline and monitoring stack for a Node.js microservice using Jenkins, Docker, Kubernetes, Prometheus, and Grafana.

---

## Steps Completed

1. **Project Setup**

   - Node.js microservice with Express and Prometheus metrics (`prom-client`).
   - Basic Jest test added.

2. **Jenkins Setup**

   - Jenkins deployed via Docker Compose.
   - Jenkins runs on [http://localhost:8083](http://localhost:8083).
   - Jenkins data is persisted using a Docker volume.

3. **Jenkins Pipeline**

   - Declarative Jenkinsfile at the project root.
   - Pipeline stages: checkout, test, build Docker image, push to DockerHub, deploy to Kubernetes.

4. **Monitoring Stack**

   - **Prometheus** and **Grafana** installed via Helm in the `monitoring` namespace.
   - Prometheus release: `monitoring-prometheus`
   - Grafana release: `monitoring-grafana`
   - Grafana available at [http://localhost:3000](http://localhost:3000) (admin/admin, via port-forward).
   - Prometheus available at [http://localhost:9090](http://localhost:9090) (via port-forward).

5. **Service & ServiceMonitor**
   - `my-microservice/service.yaml`: Exposes the app on port 8080.
   - `monitoring/my-microservice-servicemonitor.yaml`: Tells Prometheus to scrape `/metrics` from your app.

---

## Usage

### **Start Jenkins**

```sh
cd jenkins-docker
docker-compose up -d
```

### **Start your Node.js app locally**

```sh
node index.js
```

### **Deploy Service and ServiceMonitor**

```sh
kubectl apply -f my-microservice/service.yaml
kubectl apply -f monitoring/my-microservice-servicemonitor.yaml
```

### **Port-forward Prometheus and Grafana**

```sh
kubectl port-forward svc/monitoring-prometheus-kube-prometheus 9090:9090 -n monitoring
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring
```

### **Access UIs**

- **Jenkins:** [http://localhost:8083](http://localhost:8083)
- **Prometheus:** [http://localhost:9090](http://localhost:9090)
- **Grafana:** [http://localhost:3000](http://localhost:3000) (admin/admin)
- **Metrics endpoint:** [http://localhost:8080/metrics](http://localhost:8080/metrics)

---

_This project demonstrates a basic CI/CD and monitoring workflow for Kubernetes microservices._
