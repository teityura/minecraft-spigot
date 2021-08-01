FROM alpine:latest

WORKDIR /
COPY ./plugin-download.sh ./plugin-download.sh

WORKDIR /plugins
ENTRYPOINT ["/plugin-download.sh"]
