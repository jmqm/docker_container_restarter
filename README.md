Restarts Docker containers automatically on a schedule.

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
      - CONTAINERS=container # One or more, separated by spaces
      - OPTIONS=--time 300 # Five minutes to wait before killing container(s)
      - SCHEDULE=0 5 * * * # 5:00 AM daily
    depends_on
      - container

```

## Volumes _(permission required)_
- `/var/run/docker.sock` _(read/write)_

## Environment Variables
#### ⭐Required, 👍 Recommended
| Environment Variable | Info                                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| CONTAINERS ⭐        | Name of the containers to restart, separated by commas.                                                  |
| SCHEDULE ⭐          | When to run _(default is 5:00 AM)_. Info [here][cron-format-wiki] and editor [here][cron-editor].        |
| OPTIONS 👍           | Options to pass to command `docker restart`. Docs [here][docker-restart-docs].                           |

#### Optional
| Environment Variable | Info                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------ |
| TZ ¹                 | Timezone inside the container. Can mount `/etc/localtime` instead as well _(recommended)_. |

¹ See <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> for more information

## Take note of...
- All shell scripts are being ran as root.

[cron-format-wiki]: https://www.ibm.com/docs/en/db2oc?topic=task-unix-cron-format
[cron-editor]: https://crontab.guru/
[docker-restart-docs]: https://docs.docker.com/engine/reference/commandline/restart/
