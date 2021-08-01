FROM alpine:latest

RUN set -x && \
  apk add --no-cache bash

WORKDIR /
COPY ./docker-entrypoint.sh ./docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
