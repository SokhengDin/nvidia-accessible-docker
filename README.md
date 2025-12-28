# NVIDIA CUDA Development Environment

Docker setup for CUDA 12.1 with Python 3.11 and C++ development tools.

## Prerequisites

- Docker and Docker Compose installed
- NVIDIA GPU with driver installed
- NVIDIA Container Toolkit installed

## Quick Start

```bash
# Build and start container
docker-compose up -d --build

# Enter container
docker-compose exec cuda-dev bash

# Stop container
docker-compose down
```

## What's Included

- **CUDA**: 12.1.0 with development tools
- **Python**: 3.11 with PyTorch, NumPy, Jupyter, CuPy
- **C++ Tools**: g++, clang, cmake, gdb, valgrind

## Volume Mounts

- `./workspace` - Main working directory
- `./src` - C++ source files
- `./build` - Build outputs
- `./scripts` - Python scripts
- `./data` - Datasets
- `./notebooks` - Jupyter notebooks

## Ports

- `8888` - Jupyter Lab
- `6006` - TensorBoard

## Verify GPU Access

```bash
# Inside container
nvidia-smi
python -c "import torch; print(torch.cuda.is_available())"
```
