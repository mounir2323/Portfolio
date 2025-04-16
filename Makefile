
# Variables
DOCKER_COMPOSE = docker compose
DOCKER = docker
DOCKER_COMPOSEFILE = ./docker/docker-compose.yml

# Backend Variables
BACKEND_IMAGE = backend_app
BACKEND_CONTAINER = backend_container
BACKEND_DOCKERFILE = ./docker/Dockerfile.backend
BACKEND_PORT = 8081

# Frontend Variables
FRONTEND_IMAGE = frontend_app
FRONTEND_CONTAINER = frontend_container
FRONTEND_DOCKERFILE = docker/Dockerfile.frontend
FRONTEND_PORT = 8080

# Build the Docker images
build-backend:
	$(DOCKER) build -t $(BACKEND_IMAGE) -f $(BACKEND_DOCKERFILE) backend

build-frontend:
	$(DOCKER) build -t $(FRONTEND_IMAGE) -f $(FRONTEND_DOCKERFILE) frontend

# Run the containers
run-backend:
	$(DOCKER) run -d --name $(BACKEND_CONTAINER) -p $(BACKEND_PORT):8080 $(BACKEND_IMAGE)

run-frontend:
	$(DOCKER) run -d --name $(FRONTEND_CONTAINER) -p $(FRONTEND_PORT):8080 $(FRONTEND_IMAGE)

# Stop the running containers
stop:
	$(DOCKER) stop $(BACKEND_CONTAINER) $(FRONTEND_CONTAINER) || true
	$(DOCKER) rm $(BACKEND_CONTAINER) $(FRONTEND_CONTAINER) || true

# Clean up images and containers
tidy:
	$(DOCKER) system prune -f

# Use Docker Compose
up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSEFILE) up -d

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSEFILE) down --rmi all

restart:
	make down && make up

# Build and start services using Docker Compose
compose-build:
	$(DOCKER_COMPOSE) build

compose-up:
	$(DOCKER_COMPOSE) up -d

compose-down:
	$(DOCKER_COMPOSE) down --rmi all --volumes
