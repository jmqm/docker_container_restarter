Restarts Docker container automatically in a schedule.

## Usage

## docker-compose
```
services:
  container:
    # Container configuration here.
  backup:
    image: jmqm/docker_container_restarter:latest
    container_name: container_restarter
    network_mode: none
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

      - /etc/localtime:/etc/localtime:ro # Container uses date from host.
    environment:
      - CONTAINER_NAMES=container # One or more, separated by spaces
      - OPTIONS=--time 300 # Five minutes to wait before killing container(s)
      - SCHEDULE=0 5 * * * # 5:00 AM daily

```

## Volumes _(permission required)_
`/data` _(read)_- Vaultwarden's `/data` directory. Recommend setting mount as read-only.

`/backups` _(write)_ - Where to store backups to.

## Environment Variables
#### ⭐Required, 👍 Recommended
| Environment Variable | Info                                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| UID                ⭐| User ID to run the cron job as.                                                                          |
| GID                ⭐| Group ID to run the cron job as.                                                                         |
| CRON_TIME          👍| When to run _(default is every 12 hours)_. Info [here][cron-format-wiki] and editor [here][cron-editor]. |
| DELETE_AFTER       👍| Delete backups _X_ days old. Requires `read` and `write` permissions.                                    |

#### Optional
| Environment Variable | Info                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------ |
| TZ ¹                 | Timezone inside the container. Can mount `/etc/localtime` instead as well _(recommended)_. |

¹ See <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> for more information

## Errors
#### Unexpected timestamp
Mount `/etc/localtime` _(recommend mounting as read-only)_ or set `TZ` environment variable.

[cron-format-wiki]: https://www.ibm.com/docs/en/db2oc?topic=task-unix-cron-format
[cron-editor]: https://crontab.guru/
