#!/bin/sh

# --------------- [ RUN ] ---------------

docker restart $OPTIONS $CONTAINER_NAMES &> /dev/null
OUTPUT="${OUTPUT}Restarted container(s) - ${CONTAINER_NAMES}"

# ------------------ [ EXIT ] ------------------

echo "[$(date +"%F %r")] ${OUTPUT}."
