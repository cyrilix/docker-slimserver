FROM debian:stable-slim

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ARG SLIMSERVER_VERSION=7.9.3

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y wget perl libio-socket-ssl-perl locales lame && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/archives/*

RUN echo "en_US UTF-8\nfr_FR UTF-8" > /etc/locale.gen && locale-gen
ENV LANG=en_US

RUN wget --quiet -O- https://github.com/Logitech/slimserver/archive/${SLIMSERVER_VERSION}.tar.gz  | tar xz  && \
    mv slimserver-${SLIMSERVER_VERSION} slimserver

USER 1234
WORKDIR /slimserver
ENTRYPOINT ["perl", "/slimserver/slimserver.pl"]
