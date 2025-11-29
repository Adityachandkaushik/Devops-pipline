DevOps Pipeline Project - Explanation
Project Overview

This project demonstrates a complete DevOps pipeline with:

Backend: Node.js + Express + MongoDB

Frontend: HTML, CSS, JavaScript

Containerization: Docker & Docker Hub

Infrastructure Automation: Terraform (local Docker provider)

Goal: Build, containerize, and run backend and frontend applications locally, automate container deployment using Terraform, and push Docker images to Docker Hub.

Backend Setup

The backend is a Node.js Express server with MongoDB as a database.

Directory structure:

backend/
├── Dockerfile
├── package.json
└── src/
    └── index.js


Backend Dockerfile:

Base image: node:18-alpine

Set working directory: /app

Copy package.json and install dependencies (npm install)

Copy application files

Expose port 5000

Start server: npm start

Frontend Setup

Frontend is a simple HTML/CSS/JS app.

Directory structure:

frontend/
├── Dockerfile
├── app.js
├── index.html
└── style.css


Frontend Dockerfile:

Base image: node:18-alpine

Copy frontend files

Expose port 3000

Initial issues:

ERR_CONNECTION_REFUSED → caused by port conflicts

Fixed by running frontend container on host port 3001:3000

Docker Containerization

Backend:

docker build -t backend-img .
docker run -d -p 5000:5000 backend-img


Frontend:

docker build -t frontend-img .
docker run -d -p 3001:3000 frontend-img


Troubleshooting:

Port conflicts: Stopped and removed old containers using docker ps, docker stop, and docker rm.

Frontend connection refused: Verified internal port mapping and container running status.

Terraform Integration

Terraform used to automate Docker container creation.

Directory structure:

infra/terraform/
└── main.tf


Terraform commands:

terraform init
terraform plan
terraform apply


Terraform resources:

docker_image → defines backend & frontend Docker images

docker_container → defines backend & frontend containers

Issues solved:

Dependency lock file inconsistent → fixed with terraform init -upgrade

AWS credentials errors → skipped AWS, used only local Docker provider

Docker Hub Integration

Tagged and pushed images to Docker Hub:

docker tag backend-img <dockerhub-username>/backend-img:latest
docker tag frontend-img <dockerhub-username>/frontend-img:latest
docker push <dockerhub-username>/backend-img:latest
docker push <dockerhub-username>/frontend-img:latest


Benefit: Images are portable and can run on any machine.

Problems and Troubleshooting
Issue	Solution
Port already allocated	Stop/remove conflicting containers using docker ps, docker stop, docker rm
Frontend build error (package.json missing)	Corrected Dockerfile COPY step
Terraform AWS credentials missing	Used Docker provider only, removed AWS references
Connection refused	Verified container port mapping, mapped frontend to 3001 on host
Tools & Technologies Used

Node.js & Express → Backend server

HTML/CSS/JS → Frontend UI

MongoDB → Database

Docker → Containerization

Docker Hub → Image registry

Terraform → Infrastructure as Code (Docker automation)

Summary

Backend and frontend are successfully Dockerized.

Terraform automates container creation locally.

Docker images pushed to Docker Hub for portability.

Port conflicts and build issues were successfully resolved.

Full DevOps pipeline is functional on a local machine.