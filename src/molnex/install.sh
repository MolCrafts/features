#!/usr/bin/env bash

# molnex Feature Install Script
# This script installs PyTorch and NumPy for molnex ML development
# Other dependencies should be installed via pip/conda in the project

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get compute backend option (default to cpu)
BACKEND="${BACKEND:-cpu}"
CUDA_VERSION="${CUDAVERSION:-12.1}"

echo_info "Setting up molnex development environment with ${BACKEND} backend..."

# Install build tools required for compiling Python extensions
echo_info "Installing build tools..."
apt-get update
apt-get install -y --no-install-recommends build-essential
apt-get clean -y
rm -rf /var/lib/apt/lists/*

if [ "$BACKEND" = "cuda" ]; then
    echo_info "Installing CUDA toolkit ${CUDA_VERSION}..."
    
    # Convert CUDA version format for repository (e.g., 12.1 -> 12-1)
    CUDA_REPO_VERSION=$(echo ${CUDA_VERSION} | sed 's/\./-/g')
    
    # Install CUDA keyring
    if [ ! -f /tmp/cuda-keyring_1.0-1_all.deb ]; then
        wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb -O /tmp/cuda-keyring_1.0-1_all.deb
    fi
    dpkg -i /tmp/cuda-keyring_1.0-1_all.deb || echo_warn "CUDA keyring already installed"
    
    # Update apt cache
    apt-get update
    
    # Install CUDA toolkit
    echo_info "Installing CUDA toolkit (this may take a while)..."
    apt-get install -y --no-install-recommends cuda-toolkit-${CUDA_REPO_VERSION} || {
        echo_warn "Failed to install cuda-toolkit-${CUDA_REPO_VERSION}, trying alternative format..."
        apt-get install -y --no-install-recommends cuda-toolkit-${CUDA_VERSION} || {
            echo_error "CUDA toolkit installation failed."
            echo_error "Continuing with PyTorch CUDA libraries only..."
        }
    }
    
    # Clean up
    apt-get clean -y
    rm -rf /var/lib/apt/lists/*
    
    # Set environment variables for current session
    export PATH="/usr/local/cuda/bin:${PATH}"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
    
    echo_info "CUDA toolkit installation complete"
    
    # Install PyTorch with CUDA support
    echo_info "Installing PyTorch with CUDA ${CUDA_VERSION} support..."
    conda install -y pytorch pytorch-cuda=${CUDA_VERSION} -c pytorch -c nvidia
    
    echo_info "Verifying CUDA installation..."
    python3 -c "import torch; print(f'PyTorch version: {torch.__version__}'); print(f'CUDA available: {torch.cuda.is_available()}'); print(f'CUDA version: {torch.version.cuda if torch.cuda.is_available() else \"N/A\"}')" || echo_warn "CUDA verification failed - this is expected if no GPU is available"
    
else
    echo_info "Installing CPU-only PyTorch..."
    
    # Install PyTorch CPU version
    conda install -y pytorch cpuonly -c pytorch
    
    echo_info "Verifying CPU installation..."
    python3 -c "import torch; print(f'PyTorch version: {torch.__version__}'); print(f'CUDA available: {torch.cuda.is_available()}')"
fi

echo_info "Installing NumPy..."
conda install -y numpy

echo_info ""
echo_info "molnex feature installation complete!"
echo_info "Installed: PyTorch (${BACKEND}), NumPy"
echo_info "Compute backend: ${BACKEND}"
if [ "$BACKEND" = "cuda" ]; then
    echo_info "CUDA version: ${CUDA_VERSION}"
    echo_warn "Note: GPU access requires NVIDIA drivers and Container Toolkit on the host"
fi
echo_info ""
echo_info "Next steps:"
echo_info "Install other dependencies: pip install -e ."
