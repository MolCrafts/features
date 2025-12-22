# MolCrafts DevContainer Features

A collection of devcontainer features for molecular science development, providing ready-to-use development environments for Python, Rust, visualization, and machine learning workflows.

## Available Features

### molpy

Python development environment for molecular science with Jupyter support.

**Includes:**
- Python 3.x with Anaconda
- Jupyter Lab (optional)
- Development tools (black, isort)
- VS Code Python extensions

**Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molpy:latest": {
      "installJupyter": true
    }
  }
}
```

---

### molrs

Rust development environment for molecular science with WebAssembly support.

**Includes:**
- Rust toolchain (cargo, rustc, rustup)
- wasm-pack for WebAssembly
- Python and Anaconda (via dependencies)
- VS Code Rust extensions

**Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molrs:latest": {}
  }
}
```

---

### molvis

Visualization tools combining Node.js and Python for molecular visualization.

**Includes:**
- Node.js and npm
- Python environment (via molpy)
- Biome formatter
- VS Code extensions

**Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molvis:latest": {}
  }
}
```

---

### molexp

Task graph framework development environment with Python 3.12+.

**Includes:**
- Python 3.12+ with Anaconda
- molexp dependencies (Pydantic, FastAPI, Typer, Rich)
- Node.js (for UI development)
- Jupyter Lab (optional)
- Development tools

**Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molexp:latest": {
      "installJupyter": true
    }
  }
}
```

---

### molnex

ML training system with **CPU or CUDA support** for PyTorch.

**Includes:**
- PyTorch (CPU or CUDA)
- CUDA Toolkit (CUDA mode only)
- torch-scatter for graph neural networks
- Python environment (via molpy)

**CPU Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molnex:latest": {}
  }
}
```

**CUDA Usage:**
```json
{
  "features": {
    "ghcr.io/molcrafts/features/molnex:latest": {
      "backend": "cuda",
      "cudaVersion": "12.1"
    }
  },
  "runArgs": ["--gpus", "all"]
}
```

> [!IMPORTANT]
> CUDA support requires NVIDIA GPU drivers and NVIDIA Container Toolkit on the host machine.

---

## Development

### Testing Features

```bash
# Test a specific feature
devcontainer features test --features molnex

# Test all features
devcontainer features test
```

### Publishing Features

Features are published to GitHub Container Registry (ghcr.io) automatically via GitHub Actions.

---

## Documentation

- **Development Guide**: https://github.com/teslamotors/devcontainers-cli/blob/main/docs/features/test.md
- **Features Specification**: https://containers.dev/implementors/features/

---

## Feature Dependencies

```
molpy (base)
  ├── molrs (depends on molpy)
  ├── molvis (depends on molpy)
  ├── molexp (standalone)
  └── molnex (depends on molpy)
```

---

## License

See [LICENSE](LICENSE) file for details.
