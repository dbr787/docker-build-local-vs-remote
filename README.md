# Docker Build Performance Benchmark

This repository benchmarks Docker build performance between local and remote builders using Buildkite.

## Files

- `.buildkite/pipeline.yml` - Buildkite pipeline with parallel local/remote build steps
- `Dockerfile` - Large multi-layer image for benchmarking (~2GB+)

## Usage

1. Configure your Buildkite agent with remote Docker builder
2. Push this repository to your Git provider
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
