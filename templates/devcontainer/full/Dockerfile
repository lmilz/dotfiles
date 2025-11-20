FROM ubuntu:22.04


ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    ruby-full \
    zlib1g-dev \
    ca-certificates \
    python3 \
    python3-pip \
    python3-venv \
    clang \
    g++ \
    lsb-release \
    unzip \
    && rm -rf /var/lib/apt/lists/*


# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Python
RUN pip3 install --no-cache-dir \
    ipython \
    black \
    flake8 \
    mypy \
    jupyter

# Node.js 22 LTS + npm
#RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
#    && apt-get install -y nodejs \
#    && npm install -g npm@latest \
#    && npm install -g yarn

# Jekyll
RUN gem install jekyll bundler

RUN mkdir /workspace
WORKDIR /workspace

CMD [ "bash" ]