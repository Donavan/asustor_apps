#!/bin/sh

echo "pre-install"

# App Central extend timeout, but the timeout seems be counted from post-install, not pre-install, so move "docker pull" to post-install.
mkdir /share/Docker/Telegraf
mkdir /share/Docker/Telegraf/config

cfg='/share/Docker/Telegraf/config/telegraf.conf'
if [ ! -f $cfg ]; then
    #code to be run if file does not exist
  echo "[[outputs.influxdb]]" >> $cfg
  echo "    urls = [\"http://influxdb:8086\"]" >> $cfg
fi
