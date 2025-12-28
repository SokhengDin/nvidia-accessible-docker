FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV PYTHONUNBUFFERED=1

# Install system dependencies and build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    vim \
    nano \
    gdb \
    valgrind \
    clang \
    clang-format \
    clang-tidy \
    pkg-config \
    libomp-dev \
    software-properties-common \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd && \
    echo 'root:cuda' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Install Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Upgrade pip
RUN python3.11 -m pip install --upgrade pip setuptools wheel

# Install common Python packages for CUDA/ML development
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    scipy \
    scikit-learn \
    jupyter \
    jupyterlab \
    torch torchvision torchaudio \
    cupy-cuda12x

# Create workspace directory
WORKDIR /workspace

# NVCC
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}

# Expose Jupyter and SSH ports
EXPOSE 8888 22

# Start SSH service and keep container running
CMD service ssh start && /bin/bash
