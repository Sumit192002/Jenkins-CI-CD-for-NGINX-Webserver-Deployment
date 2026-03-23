Flow Diagram

<img width="1377" height="361" alt="diagram-export-12-12-2025-12_21_57-PM" src="https://github.com/user-attachments/assets/f7a04b22-e09c-4b04-84bf-552d1d3ef186" />


# Jenkins CI/CD Pipeline for NGINX Web Server Deployment

## Author

**Sumit Padiyar**
GitHub: https://github.com/sumit192002

---

# Project Overview

This project demonstrates how to build a **CI/CD pipeline using Jenkins, Docker, and GitHub** to automatically deploy an **NGINX web server** that hosts a simple website.

Whenever changes are pushed to the GitHub repository, **Jenkins automatically triggers the pipeline**, builds a Docker image, and deploys the updated website inside a Docker container.

---

# Project Architecture

```
Developer Push Code → GitHub Repository
            │
            ▼
      GitHub Webhook
            │
            ▼
         Jenkins
   (CI/CD Pipeline)
            │
            ▼
      Build Docker Image
            │
            ▼
     Deploy NGINX Container
            │
            ▼
      Website Available on Browser
```

---

# Tech Stack

* Jenkins
* Docker
* Git
* GitHub
* NGINX
* Ngrok
* Ubuntu (WSL)
* Windows 11

---

# Prerequisites

Make sure the following tools are installed:

* Windows 11
* WSL (Windows Subsystem for Linux) with Ubuntu
* Docker Desktop
* Git
* Java (required for Jenkins)

---

# Project Workflow

The CI/CD pipeline follows these steps:

1. Install and configure Jenkins
2. Create a Jenkins pipeline
3. Clone code from GitHub repository
4. Build a Docker image using NGINX
5. Deploy the container
6. Host the website
7. Trigger the pipeline automatically using GitHub Webhooks

---

# Step 1: Install Jenkins

### Update system

```bash
sudo apt update
sudo apt upgrade
```

### Install Java

```bash
sudo apt install openjdk-11-jdk -y
```

### Add Jenkins repository

```bash
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
```

```bash
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
```

### Install Jenkins

```bash
sudo apt update
sudo apt install jenkins -y
```

### Start Jenkins

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Access Jenkins:

```
http://localhost:8080
```

Install **Suggested Plugins**.

---

# Required Jenkins Plugins

Install the following plugins:

* Git Plugin
* Docker Plugin
* Pipeline Plugin

---

# Jenkins Pipeline Configuration

Create a **Pipeline Job** in Jenkins.

Select:

```
Pipeline script from SCM
```

SCM:

```
Git
```

Repository URL:

```
https://github.com/Sumit192002/CICD.git
```

Script Path:

```
Jenkinsfile
```

---

# Jenkinsfile

```groovy
pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Sumit192002/CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker buildx build --tag my-nginx-image .'
                }
            }
        }

        stage('Deploy to Docker') {
            steps {
                script {
                    sh 'docker run -d -p 8082:80 my-nginx-image'
                }
            }
        }

    }

    post {
        success {
            echo 'Deployment Successful'
        }
        failure {
            echo 'Deployment Failed'
        }
    }
}
```

---

# Dockerfile

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY index.js /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

# Hosting the Website

The container runs the NGINX web server and serves the static website.

Access the website in browser:

```
http://localhost:8082
```

---

# GitHub Webhook Integration

To automate the pipeline:

1. Go to your GitHub repository
2. Open **Settings → Webhooks**
3. Click **Add Webhook**

Payload URL:

```
http://<ngrok-url>/github-webhook/
```

Content Type:

```
application/json
```

Now every **git push** will trigger the Jenkins pipeline automatically.

---

# Using Ngrok

Ngrok allows external services like GitHub to access your local Jenkins server.

Start Ngrok:

```bash
ngrok http 8080
```

Example public URL:

```
https://abcd1234.ngrok.io
```

---

# Docker Permission Fix

Allow Jenkins user to access Docker:

```bash
sudo usermod -aG docker jenkins
```

Verify:

```bash
ls -l /run/docker.sock
```

---

# Features

* Automated CI/CD pipeline
* Dockerized NGINX deployment
* GitHub webhook integration
* Automatic build and deployment on code push
* Simple static website hosting

---

# Challenges Faced

| Issue                     | Solution                               |
| ------------------------- | -------------------------------------- |
| Port 80 already in use    | Used different port mapping            |
| Container already running | Stopped old container before deploying |
| Webhook not triggering    | Used Ngrok for public access           |

---

# Final Result

After pushing changes to GitHub:

1. Jenkins pipeline triggers automatically
2. Code is cloned from repository
3. Docker image is built
4. Container is deployed
5. Website becomes accessible in browser

---

# Conclusion

This project demonstrates how to build a **complete CI/CD pipeline using Jenkins, Docker, and GitHub**. The automation ensures that every code update is automatically built and deployed without manual intervention.

It provides a practical understanding of **DevOps automation, containerization, and continuous deployment practices**.

---
