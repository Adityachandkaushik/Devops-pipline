terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16"
    }
  }
}

provider "docker" {}

resource "docker_image" "backend" {
  name = "backend-img:latest"
}

resource "docker_container" "backend_container" {
  image = docker_image.backend.latest
  name  = "backend_container"
  ports {
    internal = 5000
    external = 5000
  }
}

# Docker image for frontend
resource "docker_image" "frontend" {
  name = "frontend-img:latest"
}

# Docker container for frontend
resource "docker_container" "frontend_container" {
  name  = "frontend_container"
  image = docker_image.frontend.latest  # warning deprecated ho sakta hai, but kaam karega
  ports {
    internal = 3000
    external = 3001   # host port
  }
  restart = "no"
  must_run = true
}
