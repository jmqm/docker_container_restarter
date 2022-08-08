#!/bin/sh

SCRIPT_COMMAND="/sbin/su-exec root:root /app/script.sh"
LOG_FILE="/app/log/log.log"

# Clear cron jobs.
echo "" | crontab -
echo "[$(date +"%F %r")] Cron jobs cleared."

# Add script to cron jobs.
(crontab -l 2>/dev/null; echo "${SCHEDULE} ${SCRIPT_COMMAND} >> ${LOG_FILE} 2>&1") | crontab -
echo "[$(date +"%F %r")] Added script to cron."

# Start crond if it's not running.
pgrep crond > /dev/null 2>&1
if [ $? -ne 0 ]; then
  /usr/sbin/crond -L /app/log/cron.log
fi

echo "[$(date +"%F %r")] Running automatically (${SCHEDULE})." > "$LOG_FILE"
tail -F "$LOG_FILE" # Keeps terminal open and writes logs.
