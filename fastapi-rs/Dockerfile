FROM rust:1.62-alpine

RUN mkdir -p /app
WORKDIR /app

RUN apk update && apk add bash gcc g++ build-base libc-dev musl-dev libpq libpq-dev
