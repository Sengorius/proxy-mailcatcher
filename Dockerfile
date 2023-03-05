FROM alpine:latest

MAINTAINER Sengorius <mail@skript-manufaktur.de>

# https://mailcatcher.me/
# https://rubygems.org/gems/mailcatcher/versions
ENV MAILCATCHER_VERSION=0.8.2

RUN apk add --no-cache \
    ca-certificates openssl sqlite-libs \
    ruby ruby-bigdecimal ruby-etc ruby-json libstdc++

RUN apk add --no-cache --virtual .build-deps \
    ruby-dev make g++ sqlite-dev && \
    gem install -v $MAILCATCHER_VERSION mailcatcher && \
    apk del .build-deps

EXPOSE 25 443

CMD ["mailcatcher", "--foreground", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=443"]
