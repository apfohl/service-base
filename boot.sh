#!/bin/sh

# Timezone
TIMEZONE="${TZ:-UTC}"
cp "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
echo $TIMEZONE > /etc/timezone

# Boot sequence
for file in /boot.d/*; do
    if [ -x "$file" ]; then
        /bin/sh $file
    fi
done

# Start services
/usr/bin/supervisord -c /etc/supervisord.conf
