#!/bin/sh

rm -rf /var/run
mkdir -p /var/run/dbus

dbus-uuidgen --ensure
dbus-daemon --system

avahi-daemon --daemonize --no-chroot

shairport-sync --name "$AIRPLAY_NAME_0" --port 3112 -o alsa -- -d $AIRPLAY_PARAMETER_0 &
shairport-sync --name "$AIRPLAY_NAME_1" --port 3113 -o alsa -- -d $AIRPLAY_PARAMETER_1 &
shairport-sync --name "$AIRPLAY_NAME_2" --port 3114 -o alsa -- -d $AIRPLAY_PARAMETER_2 &

tail -f /dev/null
