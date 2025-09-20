# latest Ubuntu LTS as of 09/18/2025
FROM ubuntu:24.04

# Prevent interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

##################### Basics #########################################
# -------------------------------
# basics
# -------------------------------
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    wget \
    git \
    unzip \
    vim \
    software-properties-common \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

##################### Trust Store ####################################
# -------------------------------
# trust store certificates
# -------------------------------
# Copy ZScaler root certificate into container
# the following certs/zscaler-root.crt is being copied from GitHub Actions
# secret into that file from within the corresponding GitHub Actions workflow
COPY certs/zscaler-root.crt /usr/local/share/ca-certificates/zscaler-root.crt

# Update trust store
RUN update-ca-certificates

##################### Python ########################################
# -------------------------------
# python 3.13
# -------------------------------
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set Python alternatives
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 2 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.13 2 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 2 \
    && update-alternatives --config python3

# Install pipx
RUN python3 -m pip install --no-cache-dir pipx \
    && python3 -m pipx ensurepath

##################### Poetry ########################################
# -------------------------------
# poetry + antlr
# -------------------------------
RUN pipx install poetry \
    && pipx install antlr4-tools

##################### Java ##########################################
# -------------------------------
# Amazon Corretto JDK 21
# -------------------------------
RUN mkdir -p /usr/share/keyrings \
    && wget -O- https://apt.corretto.aws/corretto.key \
       | gpg --dearmor -o /usr/share/keyrings/corretto.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/corretto.gpg] https://apt.corretto.aws stable main" \
       | tee /etc/apt/sources.list.d/corretto.list

RUN apt-get update && apt-get install -y java-21-amazon-corretto-jdk

##################### NodeJS ########################################
# -------------------------------
# Node.js (LTS via apt-get)
# -------------------------------
RUN apt-get update && apt-get install -y nodejs npm

##################### Claude ########################################
# -------------------------------
# Claude Code
# -------------------------------
RUN npm install -g @anthropic-ai/claude-code

##################### Environment ###################################
# -------------------------------
# Environment setup
# -------------------------------
ENV PATH="/root/.local/bin:${PATH}"

# Verify installations
RUN java -version && python3 --version && node -v && npm -v && poetry --version

# Default workdir
WORKDIR /workspace

