![Docker](https://github.com/linkyard/docker-logrotate/workflows/Docker/badge.svg)

# logrotate

This is a docker container based on Alpine Linux with `logrotate`.

## Configuration

Simply mount a directory with your logs into the container at `/logs` and optionally
configure some logrotation features with the following environment variables:

- `LOGROTATE_FILE_PATTERN` (default: `*.log`): File pattern within the `/logs` directory for logs
  to be rotated by `logrotate`
- `LOGROTATE_TRUNCATE` (default: `copytruncate`): Truncation behaviour of logrotate, use either
  `copytruncate` or `nocopytruncate`
- `LOGROTATE_COMPRESS` (default: `nocompress`): Compression behaviour for rotated files, use
  either `nocompress` or `compress`
- `LOGROTATE_ROTATE` (default: `5`): The `rotate` option of logrotate
- `LOGROTATE_SIZE` (default `50M`): the `size` option of logrotate

If you want to use a different logrotate configuration, mount a `logrotate.conf` at `/etc/logrotate.conf`
into the container. The environment variables mentioned above have no effect if you supply your own
logrotate configuration file.

By default, `logrotate` is run periodically every 15 minutes. You can override the cron schedule with
the environment variable `LOGROTATE_CRON`. Use one of Alpine Linux' predefined periods
(`15min`, `hourly`, `daily`, `weekly` or `monthly`) or specify a cron schedule expression like
`5 4 * * *` (at 04:05 every day). If you are unsure about the cron schedule expression syntax,
consult a tool like [crontab guru](https://crontab.guru/).

## Examples

```bash
docker run \
  -v /path/to/my/logs:/logs \
  -e LOGROTATE_FILE_PATTERN="*.log" \
  # don't rotate at all but truncate logs when they exceed the configured rotation size
  -e LOGROTATE_ROTATE="0" \
  # run logrotate every 5 minutes
  -e LOGROTATE_CRON="*/5 0 0 0 0" \
  linkyard:logrotate
```

## Attribution

This image is somewhat similar to the no longer maintained [blacklabelops/logrotate](https://github.com/blacklabelops/logrotate)
but a lot simpler to use and maintain.


# Usage
It's double published (github and private gcr repo).

`docker run ghcr.io/linkyard/logrotate`
or
`docker run eu.gcr.io/linkyard-191615/linkyard-cloud/logrotate`
