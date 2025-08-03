FROM alpine:latest

LABEL org.opencontainers.image.authors="Sengorius <mail@skript-manufaktur.de>, Samuel Cochran <sj26@sj26.com>"
LABEL org.opencontainers.image.vendor="Skript-Manufaktur"
LABEL org.opencontainers.image.source="https://github.com/Sengorius/proxy-mailcatcher"
LABEL org.opencontainers.image.title="Proxy-Mailcatcher"

# https://mailcatcher.me/
# https://rubygems.org/gems/mailcatcher/versions
ENV MAILCATCHER_VERSION=0.10.0

RUN apk add --no-cache \
    ca-certificates openssl sqlite-libs \
    ruby ruby-bigdecimal libstdc++

RUN apk add --no-cache --virtual .build-deps \
    ruby-dev make g++ sqlite-dev && \
    gem install -v $MAILCATCHER_VERSION mailcatcher && \
    apk del .build-deps

EXPOSE 25 443

CMD ["mailcatcher", "--foreground", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=443"]
