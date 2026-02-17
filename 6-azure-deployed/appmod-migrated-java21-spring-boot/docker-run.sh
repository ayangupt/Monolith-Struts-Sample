#!/bin/bash
# Docker Run Script for SkiShop Application
# This script provides multiple options for running the containerized application

set -e

CONTAINER_NAME="skishop-app"
IMAGE_NAME="skishop-monolith:1.0.0"
HOST_PORT=8080
CONTAINER_PORT=8080

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to remove existing container
remove_existing_container() {
    if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo -e "${YELLOW}Removing existing container: ${CONTAINER_NAME}${NC}"
        docker rm -f ${CONTAINER_NAME} > /dev/null 2>&1
    fi
}

# Option 1: Run with H2 in-memory database (easiest for testing)
run_with_h2() {
    echo -e "${GREEN}Starting SkiShop with H2 in-memory database...${NC}"
    remove_existing_container
    
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${HOST_PORT}:${CONTAINER_PORT} \
        -e SPRING_PROFILES_ACTIVE=dev \
        -v "$(pwd)/logs:/app/logs" \
        --memory=512m \
        --cpus=1 \
        ${IMAGE_NAME}
    
    echo -e "${GREEN}✓ Container started successfully!${NC}"
    echo -e "Application will be available at: http://localhost:${HOST_PORT}"
    echo -e "H2 Console available at: http://localhost:${HOST_PORT}/h2-console"
    echo -e "\nTo view logs: ${YELLOW}docker logs -f ${CONTAINER_NAME}${NC}"
}

# Option 2: Run with PostgreSQL on host (Linux/WSL)
run_with_postgres_host() {
    echo -e "${GREEN}Starting SkiShop with PostgreSQL on host...${NC}"
    remove_existing_container
    
    # Get Docker bridge gateway IP
    DOCKER_HOST_IP=$(docker network inspect bridge -f '{{range .IPAM.Config}}{{.Gateway}}{{end}}')
    echo -e "Using Docker host IP: ${YELLOW}${DOCKER_HOST_IP}${NC}"
    
    # Prompt for database password
    read -sp "Enter PostgreSQL password: " DB_PASSWORD
    echo
    
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${HOST_PORT}:${CONTAINER_PORT} \
        -e SPRING_DATASOURCE_URL="jdbc:postgresql://${DOCKER_HOST_IP}:5432/skishop" \
        -e SPRING_DATASOURCE_USERNAME=skishop \
        -e DB_PASSWORD="${DB_PASSWORD}" \
        -v "$(pwd)/logs:/app/logs" \
        --memory=512m \
        --cpus=1 \
        ${IMAGE_NAME}
    
    echo -e "${GREEN}✓ Container started successfully!${NC}"
    echo -e "Application will be available at: http://localhost:${HOST_PORT}"
    echo -e "\nTo view logs: ${YELLOW}docker logs -f ${CONTAINER_NAME}${NC}"
}

# Option 3: Run with external PostgreSQL
run_with_postgres_external() {
    echo -e "${GREEN}Starting SkiShop with external PostgreSQL...${NC}"
    remove_existing_container
    
    read -p "Enter PostgreSQL host: " PG_HOST
    read -p "Enter PostgreSQL port [5432]: " PG_PORT
    PG_PORT=${PG_PORT:-5432}
    read -p "Enter database name [skishop]: " DB_NAME
    DB_NAME=${DB_NAME:-skishop}
    read -p "Enter PostgreSQL username: " DB_USER
    read -sp "Enter PostgreSQL password: " DB_PASSWORD
    echo
    
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${HOST_PORT}:${CONTAINER_PORT} \
        -e SPRING_DATASOURCE_URL="jdbc:postgresql://${PG_HOST}:${PG_PORT}/${DB_NAME}" \
        -e SPRING_DATASOURCE_USERNAME="${DB_USER}" \
        -e DB_PASSWORD="${DB_PASSWORD}" \
        -v "$(pwd)/logs:/app/logs" \
        --memory=512m \
        --cpus=1 \
        ${IMAGE_NAME}
    
    echo -e "${GREEN}✓ Container started successfully!${NC}"
    echo -e "Application will be available at: http://localhost:${HOST_PORT}"
    echo -e "\nTo view logs: ${YELLOW}docker logs -f ${CONTAINER_NAME}${NC}"
}

# Option 4: Run with host network mode (Linux only - simplest for local PostgreSQL)
run_with_host_network() {
    echo -e "${GREEN}Starting SkiShop with host network mode...${NC}"
    remove_existing_container
    
    read -sp "Enter PostgreSQL password: " DB_PASSWORD
    echo
    
    docker run -d \
        --name ${CONTAINER_NAME} \
        --network host \
        -e SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/skishop" \
        -e SPRING_DATASOURCE_USERNAME=skishop \
        -e DB_PASSWORD="${DB_PASSWORD}" \
        -v "$(pwd)/logs:/app/logs" \
        --memory=512m \
        --cpus=1 \
        ${IMAGE_NAME}
    
    echo -e "${GREEN}✓ Container started successfully!${NC}"
    echo -e "Application will be available at: http://localhost:${HOST_PORT}"
    echo -e "\nTo view logs: ${YELLOW}docker logs -f ${CONTAINER_NAME}${NC}"
}

# Display menu
show_menu() {
    echo -e "\n${GREEN}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║     SkiShop Docker Run Configuration           ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}\n"
    echo "Select database configuration:"
    echo "  1) H2 In-Memory Database (recommended for testing)"
    echo "  2) PostgreSQL on Host Machine (Linux/WSL)"
    echo "  3) External PostgreSQL Server"
    echo "  4) Host Network Mode (Linux only - uses localhost)"
    echo "  5) Exit"
    echo
}

# Main script
main() {
    if [ ! -f "Dockerfile" ]; then
        echo -e "${RED}Error: Dockerfile not found. Are you in the correct directory?${NC}"
        exit 1
    fi
    
    while true; do
        show_menu
        read -p "Enter your choice [1-5]: " choice
        
        case $choice in
            1)
                run_with_h2
                break
                ;;
            2)
                run_with_postgres_host
                break
                ;;
            3)
                run_with_postgres_external
                break
                ;;
            4)
                run_with_host_network
                break
                ;;
            5)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Please select 1-5.${NC}"
                ;;
        esac
    done
    
    echo -e "\n${YELLOW}Waiting for application to start...${NC}"
    sleep 5
    
    echo -e "\n${GREEN}Checking application health...${NC}"
    for i in {1..12}; do
        if curl -sf http://localhost:${HOST_PORT}/actuator/health > /dev/null 2>&1; then
            echo -e "${GREEN}✓ Application is healthy and ready!${NC}"
            echo -e "\n${GREEN}╔════════════════════════════════════════════════╗${NC}"
            echo -e "${GREEN}║  Application URL: http://localhost:${HOST_PORT}${NC}"
            echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}\n"
            exit 0
        fi
        echo -n "."
        sleep 5
    done
    
    echo -e "\n${RED}Warning: Application may not have started properly.${NC}"
    echo -e "Check logs with: ${YELLOW}docker logs ${CONTAINER_NAME}${NC}"
}

main "$@"
