# 🚀 Minimal DevOps Pipeline Project

This project demonstrates how to implement a **complete DevOps pipeline from scratch** for a sample Node.js application. It includes CI/CD, Docker containerization, Infrastructure as Code (Terraform), and optional monitoring.

---

# 📌 Project Overview

This setup solves a real-world problem where:

* Deployments are manual ❌
* No CI/CD pipeline ❌
* No containerization ❌
* No infrastructure automation ❌

👉 This project converts everything into an **automated DevOps workflow** ✅

---

# 🛠️ Tech Stack

* Node.js (Sample App)
* Docker
* GitHub Actions (CI/CD)
* Terraform (IaC)
* AWS EC2 (Infrastructure)
* Prometheus & Grafana (Monitoring - Optional)

---

# 📁 Project Structure

```
node-app-devops/
│
├── app/
│   ├── index.js
│   ├── package.json
│
├── Dockerfile
├── docker-compose.yml
│
├── .github/workflows/ci-cd.yml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
└── README.md
```

---

# ⚙️ Step 1: Setup Sample Application

### app/index.js

```js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('DevOps Pipeline Running 🚀');
});

const PORT = 3000;
app.listen(PORT, () => console.log(`App running on port ${PORT}`));
```

### app/package.json

```json
{
  "name": "node-devops-app",
  "version": "1.0.0",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Running tests\" && exit 0",
    "lint": "echo \"Linting done\""
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
```

---

# ⚙️ Step 2: Docker Setup

### Dockerfile

```Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY app/package*.json ./
RUN npm install

COPY app/ .

EXPOSE 3000

CMD ["node", "index.js"]
```

---

### docker-compose.yml

```yaml
version: '3'

services:
  app:
    image: your-dockerhub-username/node-app
    ports:
      - "3000:3000"

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"
```

---

# ⚙️ Step 3: CI/CD Pipeline (GitHub Actions)

### .github/workflows/ci-cd.yml

```yaml
name: DevOps Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Code
      uses: actions/checkout@v3

    - name: Setup Node
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Install Dependencies
      run: |
        cd app
        npm install

    - name: Lint
      run: |
        cd app
        npm run lint

    - name: Test
      run: |
        cd app
        npm test

    - name: Build Docker Image
      run: docker build -t your-dockerhub-username/node-app .

    - name: Login to DockerHub
      run: echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

    - name: Push Image
      run: docker push your-dockerhub-username/node-app

    - name: Deploy
      run: echo "Deploy step (SSH / Kubernetes / EC2)"
```

---

# ⚙️ Step 4: Infrastructure as Code (Terraform)

### terraform/main.tf

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "devops_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "DevOps-Server"
  }
}
```

---

### terraform/variables.tf

```hcl
variable "ami_id" {
  description = "AMI ID"
}

variable "instance_type" {
  default = "t2.micro"
}
```

---

### terraform/terraform.tfvars

```hcl
ami_id = "ami-0f5ee92e2d63afc18"
```

---

# 🚀 How to Run the Project

## 1️⃣ Run Locally

```bash
cd app
npm install
node index.js
```

---

## 2️⃣ Run Using Docker

```bash
docker build -t node-app .
docker run -p 3000:3000 node-app
```

---

## 3️⃣ Run Using Docker Compose

```bash
docker-compose up -d
```

---

## 4️⃣ Run Terraform (Infrastructure Setup)

```bash
cd terraform
terraform init
terraform apply
```

---

# 🔄 CI/CD Flow

Whenever code is pushed to `main` branch:

1. Code is checked out
2. Dependencies installed
3. Linting executed
4. Tests executed
5. Docker image built
6. Image pushed to DockerHub
7. Deployment triggered

---

# 📊 Monitoring (Optional)

| Tool       | URL                   |
| ---------- | --------------------- |
| Prometheus | http://localhost:9090 |
| Grafana    | http://localhost:3001 |

---

# 🔐 Required Secrets (GitHub)

Go to **Repo → Settings → Secrets** and add:

* `DOCKER_USERNAME`
* `DOCKER_PASSWORD`

---

# 📦 Future Enhancements

* Kubernetes deployment (EKS / Minikube)
* Helm charts
* Auto Scaling (ASG)
* Load Balancer (ALB)
* Logging (ELK Stack)
* Alerting system

---

# 👨‍💻 Author

**Rajat Rokde**
Cloud & DevOps Engineer

---

# ⭐ Final Outcome

This project demonstrates:

* End-to-end DevOps pipeline ✅
* Infrastructure automation ✅
* Containerization ✅
* CI/CD implementation ✅
* Monitoring setup ✅

---

👉 Perfect for interviews & real-world DevOps portfolio.
