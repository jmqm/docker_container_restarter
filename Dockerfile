ARG ARCH=
FROM ${ARCH}alpine:latest

RUN apk add --update --no-cache \
    su-exec \
    docker-cli \
    tzdata

ENV SCHEDULE "0 5 * * *"
ENV CONTAINERS ""
ENV OPTIONS ""

COPY /entrypoint.sh /app/
COPY /script.sh /app/

RUN mkdir /app/log/ && \
    chown -R root:root /app/ && \
    chmod -R 777 /app/

ENTRYPOINT ["/app/entrypoint.sh"]
