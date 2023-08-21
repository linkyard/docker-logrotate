FROM alpine:3.18

# renovate: datasource=github-tags depName=logrotate/logrotate
ENV LOGROTATE_VERSION=3.17.0

RUN set -x \
  && apk add --no-cache logrotate>=${LOGROTATE_VERSION} tini tzdata moreutils \
  && rm /etc/logrotate.conf && rm -r /etc/logrotate.d \
  && mv /etc/periodic/daily/logrotate /etc/.logrotate.cronjob

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/logs"]

ENTRYPOINT ["tini", "-g", "--"]
CMD ["/entrypoint.sh"]
