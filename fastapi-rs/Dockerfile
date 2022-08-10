FROM rust:1.62-alpine

ENV RUSTFLAGS="-C target-feature=-crt-static"
RUN mkdir -p /app
WORKDIR /app

RUN apk update && apk add bash gcc g++ build-base libc-dev musl-dev libpq libpq-dev
RUN cargo install cargo-watch
