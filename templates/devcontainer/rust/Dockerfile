FROM rust:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN rustup component add clippy rustfmt
RUN cargo install cargo-watch

CMD [ "bash" ]