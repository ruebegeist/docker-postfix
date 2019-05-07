FROM ubuntu:18.04

RUN apt-get -y -q -q update \
    && echo "postfix postfix/main_mailer_type string Internet Site" | debconf-set-selections \
    && echo "postfix postfix/mailname string mail.example.com" | debconf-set-selections \
    && apt-get install -y --no-install-recommends --no-install-suggests postfix=3.3.0-1ubuntu0.2 \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 25/tcp 465/tcp 587/tcp

CMD ["postfix", "start-fg"]