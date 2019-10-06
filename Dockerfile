FROM alpine:latest

# Environment
ENV ENV /etc/profile

# General
RUN apk update
RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
RUN mkdir -p /data/logs

# Timezone
RUN apk add --no-cache tzdata

# Supervisor
RUN apk add --no-cache supervisor
RUN mkdir -p /etc/supervisord.d
COPY supervisord/supervisord.conf /etc/supervisord.conf

# Rsyslogd
RUN apk add --no-cache rsyslog
COPY rsyslogd/rsyslog.conf /etc/rsyslog.conf
RUN mkdir -p /etc/rsyslog.d/
COPY rsyslogd/supervisord.conf /etc/supervisord.d/rsyslogd.conf

# Boot
RUN mkdir -p /boot.d
COPY boot.sh /boot.sh

# Entrypoint
ENTRYPOINT ["sh", "boot.sh"]
