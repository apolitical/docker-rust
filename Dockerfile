FROM debian:stable-slim as builder

RUN apt-get update \
 && apt-get install -y \
    curl \
    build-essential

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="${PATH}:/root/.cargo/bin"
