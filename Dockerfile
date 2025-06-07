FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    tmate \
    sudo \
    iptables \
    uidmap \
    unzip \
    vim

# Install Docker CE
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Add a non-root user (optional)
RUN useradd -ms /bin/bash dev && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Script to start Docker daemon and tmate
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run both on container start
CMD ["/start.sh"]
