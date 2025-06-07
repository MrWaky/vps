FROM ubuntu:22.04

# Install dependencies and Docker
RUN apt update && \
    apt install -y \
        software-properties-common \
        wget \
        curl \
        git \
        openssh-client \
        tmate \
        python3 \
        ca-certificates \
        gnupg \
        lsb-release && \
    mkdir -m 0755 -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) \
    signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update && \
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt clean

# Create a dummy index page to keep the service alive
RUN mkdir -p /app && echo "Tmate Session Running..." > /app/index.html
WORKDIR /app

# Expose a fake web port to trick Railway into keeping container alive
EXPOSE 6080

# Start dummy web server and tmate
CMD python3 -m http.server 6080 & \
    tmate -F
