# End-to-End Containerized Web Application on Azure

## Project Overview

This project demonstrates a complete DevOps lifecycle, transitioning a static web application from a local development environment to a production-ready, orchestrated cluster in the cloud. The primary focus was on implementing **Infrastructure as Code (IaC)** concepts, containerization best practices, and a fully automated **CI/CD pipeline**.

## Technical Architecture

### 1. Local Development & Containerization

The foundation of the project began with **Docker Desktop** on a Windows environment.

* **Technology:** Docker (Linux-based Alpine images).
* **Process:** Created a custom Docker image using a multi-stage approach to package the web source code with an Nginx web server.
* **Validation:** Performed local testing and port mapping to verify container stability before cloud migration.

### 2. Cloud Infrastructure (Azure)

The infrastructure was provisioned using the **Azure CLI** to ensure a repeatable setup.

* **Azure Container Registry (ACR):** A private Docker registry was established to store and manage container images securely.
* **Azure Kubernetes Service (AKS):** A managed Kubernetes cluster was deployed to handle container orchestration.
* **Service Integration:** An RBAC-based "handshake" (AcrPull role) was configured between AKS and ACR, allowing the cluster to securely retrieve images.

### 3. Automated CI/CD Pipeline

The project utilizes **Azure Pipelines** (YAML-based) to automate the transition from code commit to live deployment.

* **Continuous Integration (CI):** The pipeline triggers on every push to the main branch, builds a new Docker image, and tags it with a unique Build ID for version control.
* **Continuous Deployment (CD):** A multi-stage pipeline architecture was used. The deployment stage utilizes a **Kubernetes Service Connection** with cluster admin credentials to push updates to the live environment.

### 4. Kubernetes Orchestration

The application is managed within the AKS cluster using declarative **Kubernetes Manifests**.

* **Deployments:** Configured with multiple replicas to ensure High Availability (HA). This setup ensures that if one pod fails, the cluster automatically maintains the desired state.
* **Resource Management:** Defined CPU and Memory requests and limits to ensure efficient cluster utilization and prevent resource contention.
* **Networking:** Implemented a **Kubernetes Service** of type **LoadBalancer**. This triggers Azure to provision a Public IP address and distribute incoming traffic across the active pods.
* **Security:** Integrated **ImagePullSecrets** within the deployment manifest to manage authentication between the Kubernetes namespace and the private Azure registry.

## Key Technical Achievements

* **Zero-Downtime Strategy:** Utilized Kubernetes rolling update logic through the automated pipeline.
* **Automated Versioning:** Moved away from "latest" tags to specific Build ID tagging for better rollback capabilities.
* **Scalability:** Built an infrastructure capable of scaling from a single node to a multi-node production environment with minimal configuration changes.
* **Environment Consistency:** Guaranteed that the environment used in local Docker testing was identical to the production AKS environment.

## Tools & Technologies

* **Cloud Provider:** Microsoft Azure
* **Orchestration:** Azure Kubernetes Service (AKS)
* **Registry:** Azure Container Registry (ACR)
* **CI/CD:** Azure DevOps Pipelines
* **Containerization:** Docker Desktop
* **Configuration:** YAML, Kubernetes Manifests
* **CLI:** Azure CLI, Kubectl