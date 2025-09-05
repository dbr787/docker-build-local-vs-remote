# Docker Build Performance Benchmark

[![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/new?template=https://github.com/dbr787/docker-build-local-vs-remote)

This repository benchmarks Docker build performance between local and remote builders using Buildkite.

## Files

- `.buildkite/pipeline.yml` - Buildkite pipeline with parallel local/remote build steps
- `Dockerfile` - Large multi-layer image for benchmarking (~2GB+)

## Usage

### Quick Setup
Click the "Add to Buildkite" button above to automatically create a pipeline in your Buildkite organization.

### Manual Setup
1. Configure your Buildkite agent with remote Docker builder
2. Fork this repository 
3. Create a Buildkite pipeline using `.buildkite/pipeline.yml`
4. Run the pipeline to compare build times

The pipeline uses environment variables to control build location:
- Local build: `DOCKER_CONTEXT=default` and `BUILDKIT_HOST=""`
- Remote build: Uses agent's default configuration

## Results

Check build logs for timing output from the `time` command.

The large Dockerfile includes:
- Multiple language runtimes (Python, Node.js, Java, Go, etc.)
- Large packages (TensorFlow, PyTorch, etc.)
- 500MB dummy file
- Linux kernel source code
- Development tools and utilities
