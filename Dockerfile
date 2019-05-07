FROM ubuntu:18.04

RUN apt-get -y -q -q update \
    && echo "postfix postfix/main_mailer_type string Internet Site" | debconf-set-selections \
    && echo "postfix postfix/mailname string mail.example.com" | debconf-set-selections \
    && apt-get install -y --no-install-recommends --no-install-suggests postfix=3.3.0-1ubuntu0.2 \
    && rm -rf /var/lib/apt/lists/*

ENV MAILNAME mail.example.com
ENV MY_NETWORKS 172.17.0.0/16 127.0.0.0/8
ENV MY_DESTINATION localhost.localdomain, localhost
ENV ROOT_ALIAS admin@example.com

VOLUME /etc/postfix

EXPOSE 25/tcp 465/tcp 587/tcp

HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 CMD postfix status || exit 1

CMD ["postfix", "start-fg"]