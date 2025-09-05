# Large Docker image for benchmarking build performance
FROM ubuntu:22.04

# Install base packages and create large layers
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    nodejs \
    npm \
    openjdk-11-jdk \
    maven \
    gradle \
    golang-go \
    ruby \
    php \
    composer \
    && rm -rf /var/lib/apt/lists/*

# Install large Python packages
RUN pip3 install \
    tensorflow \
    pytorch \
    numpy \
    pandas \
    scikit-learn \
    matplotlib \
    seaborn \
    jupyter \
    flask \
    django

# Install Node.js packages globally
RUN npm install -g \
    typescript \
    webpack \
    babel-cli \
    eslint \
    prettier \
    react-scripts \
    next \
    express \
    lodash

# Create a large file to increase image size
RUN dd if=/dev/zero of=/tmp/largefile bs=1M count=500

# Download and compile a large source code project
WORKDIR /tmp
RUN git clone https://github.com/torvalds/linux.git --depth 1 linux-source

# Install additional development tools
RUN apt-get update && apt-get install -y \
    clang \
    llvm \
    cmake \
    ninja-build \
    gdb \
    valgrind \
    strace \
    htop \
    vim \
    emacs \
    && rm -rf /var/lib/apt/lists/*

# Create multiple large layers with different content
COPY . /app
WORKDIR /app

# Final layer with runtime setup
RUN echo "Docker build performance test image" > /app/README.txt && \
    mkdir -p /app/logs /app/data /app/cache

EXPOSE 8080 3000 5000
CMD ["echo", "Docker build performance test completed"]
