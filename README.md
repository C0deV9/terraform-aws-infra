# 🧩 Members CRUD App — Infrastructure & CI/CD Setup

This repository implements a **Node.js CRUD application** deployed on **AWS EC2** with a fully automated **CI/CD pipeline (GitHub Actions)** and **Terraform-based infrastructure**.  
The setup is designed for simplicity, modularity, and scalability.

---

## 🚀 Overview

### Components
- **Backend** — Node.js Express API for managing members.
- **Frontend** — React application.
- **Infrastructure** — AWS resources provisioned with Terraform.
- **CI/CD Pipeline** — GitHub Actions automating build, test, and deployment.
- **Docker** — Containerized frontend and backend applications.

---

## 🏗️ Infrastructure Setup (Terraform)

### Prerequisites
- Terraform v1.7+
- AWS CLI configured with an IAM user having `AdministratorAccess`
- Docker installed locally (for image verification)

### Steps to Deploy Infrastructure

1. **Navigate to the Terraform directory**
   ```bash
    cd terraform
    ```

2. **Navigate to the Terraform directory**
   ```bash
    terraform init
    ```

3. **Navigate to the Terraform directory**
   ```bash
    terraform validate
    terraform plan
    ```

4. **Navigate to the Terraform directory**
   ```bash
    terraform apply -auto-approve
    ```

5. **Retrieve Outputs**
    ```text
    After successful deployment, Terraform will display:
    EC2 instance public IP
    Security group IDs
    Load balancer endpoint (if used)
    ```

## ⚙️ CI/CD Pipeline (GitHub Actions)

### The pipeline is defined in .github/workflows/cicd.yml.

#### Workflow Stages

1. **Test Stage**

    * Installs dependencies and runs tests for both frontend and backend.

2. **Build & Push Stage**

    * Builds Docker images for backend and frontend.
    * Pushes them to Docker Hub.

3. **Deploy Stage**

    * SSHs into EC2 instances (Amazon Linux).
    * Pulls the latest Docker images.
    * Runs the containers using docker compose.

4. **Manual Approval**

    * Requires human approval before production deployment.

5. **Notification Stage**

    * Sends an email alert if the pipeline fails at any step.

## 🧱 Architecture Decisions
1. **Amazon Linux for EC2**

    * Chosen for better integration with AWS tools and lightweight performance.
    * Docker installed during EC2 provisioning via Terraform user data.
    * Avoids repeated Docker installation during deployment.

2. **Modular Terraform Design**

    * Each component (vpc, security, alb, ec2) is isolated into its own module.
    * Encourages reusability and easier maintenance.

3. **GitHub Actions for CI/CD**

    * Uses a single pipeline for test, build, and deploy.
    * Manual approval for production ensures safety.
    * Docker images hosted on Docker Hub for portability.

4. **Docker Compose for Deployment**

    * Simplifies multi-container orchestration.
    * Easy rollback and restart support.

## 🔒 Security Considerations

* **IAM Best Practices** — Terraform uses least-privilege IAM roles.
* **Secret Management** — All sensitive credentials stored in GitHub Secrets.
* **SSH Key Access** — EC2 SSH access restricted to pipeline via GitHub Secrets.
* **Security Groups**:
    * ALB exposes port 80 (HTTP) publicly.
    * EC2 only accepts traffic from ALB.
    * Database only accepts traffic from EC2.
* **HTTPS Ready** — Can integrate with ACM and ALB for SSL termination.

## 💰 Cost Optimization

* **Single EC2 instance** for staging and production (parameterized).
* **Auto-stop non-production EC2** during off-hours (configurable via Terraform).
* **Free-tier AWS services** leveraged wherever possible.
* **Containerized deployment** ensures minimal resource wastage.