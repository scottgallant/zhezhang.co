FROM alpine:3.2
MAINTAINER Zhe Zhang (https://github.com/zhe)

RUN apk add --update wget && rm -rf /var/cache/apk/*

ENV HUGO_VERSION 0.14
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64

WORKDIR /tmp

RUN wget --no-check-certificate https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz \
    && tar -xzf ${HUGO_BINARY}.tar.gz \ 
    && mv /tmp/${HUGO_BINARY}/${HUGO_BINARY} /usr/local/bin/hugo \
    && rm -rf /tmp/*

RUN mkdir -p /srv/hugo
COPY . /srv/hugo

WORKDIR /srv/hugo
EXPOSE 1313
CMD ["hugo", "server", "--watch"]