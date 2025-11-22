FROM debian:bookworm-slim

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
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --profile minimal
ENV PATH="/root/.cargo/bin:${PATH}"

# Jekyll
RUN gem install --no-document jekyll bundler

RUN mkdir /workspace
WORKDIR /workspace

CMD [ "bash" ]