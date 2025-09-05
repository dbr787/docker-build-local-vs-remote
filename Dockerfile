# Docker image for benchmarking build performance
FROM ubuntu:22.04

# Install basic packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install minimal Python packages
RUN pip3 install requests flask

# Create some files for benchmarking
RUN dd if=/dev/zero of=/tmp/largefile1 bs=1M count=50
RUN dd if=/dev/zero of=/tmp/largefile2 bs=1M count=50

# Create some directories
RUN for i in {1..25}; do mkdir -p /tmp/layer$i && echo "Content layer $i" > /tmp/layer$i/file.txt; done

# Create application directories and files
COPY . /app
WORKDIR /app

# Create final files
RUN mkdir -p /app/logs /app/data /app/cache
RUN dd if=/dev/zero of=/app/data/benchmark.dat bs=1M count=50
RUN echo "Docker build performance test image - $(date)" > /app/README.txt

EXPOSE 8080
CMD ["echo", "Docker build performance test completed"]
