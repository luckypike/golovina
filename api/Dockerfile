FROM ruby:3.0.3-alpine

RUN mkdir -p /app
WORKDIR /app

ENV GEM_HOME /app/.local/ruby/3.0
ENV PATH "/app/.local/ruby/3.0/bin:${PATH}"

RUN apk update && apk add bash git curl openssh g++ make python3 python2 imagemagick vips-dev yarn nodejs tzdata postgresql-dev postgresql-client vim gcompat
RUN gem install bundler

RUN echo 'IRB.conf[:HISTORY_FILE] = "/app/.local/.irb_history"' | tee -a ~/.irbrc
