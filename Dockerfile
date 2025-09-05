# Large Docker image for benchmarking build performance
FROM ubuntu:22.04

# Install basic packages first
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    vim \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install some Python packages (but not the huge ones)
RUN pip3 install \
    requests \
    flask \
    numpy \
    pandas

# Create large files across multiple layers
RUN dd if=/dev/zero of=/tmp/largefile1 bs=1M count=150
RUN dd if=/dev/zero of=/tmp/largefile2 bs=1M count=150
RUN dd if=/dev/zero of=/tmp/largefile3 bs=1M count=150

# Install Node.js from NodeSource (more reliable)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install some global npm packages
RUN npm install -g \
    typescript \
    eslint \
    prettier

# Create more layers with file operations
RUN for i in {1..100}; do mkdir -p /tmp/layer$i && echo "Large content layer $i" > /tmp/layer$i/file.txt; done

# Create application directories and files
COPY . /app
WORKDIR /app

# Create final large files and directories
RUN mkdir -p /app/logs /app/data /app/cache /app/temp
RUN dd if=/dev/zero of=/app/data/benchmark.dat bs=1M count=200
RUN echo "Docker build performance test image - $(date)" > /app/README.txt

EXPOSE 8080 3000 5000
CMD ["echo", "Docker build performance test completed"]
