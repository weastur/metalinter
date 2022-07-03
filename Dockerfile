FROM haskell:9.2.3-buster as hadolint

RUN git clone --depth 1 --branch v2.10.0 https://github.com/hadolint/hadolint
WORKDIR /hadolint
RUN stack install --install-ghc

FROM golang:1.18.3-bullseye as checkmake

ENV BUILDER_NAME="Pavel Sapezhka"
ENV BUILDER_EMAIL="me@weastur.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
        pandoc \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch 0.2.1 https://github.com/mrtazz/checkmake
WORKDIR /go/checkmake
RUN make

FROM rust:1.62.0-bullseye as dotenv

RUN git clone --depth 1 --branch v3.2.0 https://github.com/dotenv-linter/dotenv-linter.git
WORKDIR /dotenv-linter
RUN cargo build --release

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        yamllint \
        shellcheck \
        npm \
        python3-pip \
    && pip3 install --no-cache-dir sqlfluff \
    && npm install -g markdownlint-cli \
    && npm install -g jsonlint \
    && rm -rf /var/lib/apt/lists/*

COPY --from=hadolint /root/.local/bin/hadolint /usr/local/bin/hadolint
COPY --from=checkmake /go/checkmake/checkmake /usr/local/bin/checkmake
COPY --from=dotenv /dotenv-linter/target/release/dotenv-linter /usr/local/bin/dotenv-linter
