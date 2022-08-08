#!/bin/sh

# --------------- [ RUN ] ---------------

docker restart $OPTIONS $CONTAINERS &> /dev/null
OUTPUT="${OUTPUT}Restarted container(s) - ${CONTAINERS}"

# ------------------ [ EXIT ] ------------------

echo "[$(date +"%F %r")] ${OUTPUT}."
