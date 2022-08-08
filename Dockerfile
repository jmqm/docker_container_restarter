ARG ARCH=
FROM ${ARCH}alpine:latest

RUN apk add --update --no-cache \
    su-exec \
    docker-cli \
    tzdata

ENV SCHEDULE "0 5 * * *"
ENV CONTAINERS ""
ENV OPTIONS ""

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./script.sh /app/

RUN mkdir /app/log/

ENTRYPOINT ["entrypoint.sh"]
