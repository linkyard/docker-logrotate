FROM alpine:3.17

RUN set -x \
  && apk add --no-cache logrotate tini tzdata moreutils \
  && rm /etc/logrotate.conf && rm -r /etc/logrotate.d \
  && mv /etc/periodic/daily/logrotate /etc/.logrotate.cronjob

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/logs"]

ENTRYPOINT ["tini", "-g", "--"]
CMD ["/entrypoint.sh"]
