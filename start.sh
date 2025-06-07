#!/bin/bash

# Start Docker daemon in background
dockerd &

# Wait for Docker to be ready (basic check)
echo "Waiting for Docker daemon to start..."
until docker info >/dev/null 2>&1; do
  sleep 1
done
echo "Docker is up!"

# Start tmate in foreground
tmate -F
