
FROM ubuntu:22.04


ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    wget \
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


RUN mkdir /workspace
WORKDIR /workspace

CMD [ "bash" ]