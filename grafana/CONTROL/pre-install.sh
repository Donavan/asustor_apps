#!/bin/sh

echo "pre-install"

# App Central extend timeout, but the timeout seems be counted from post-install, not pre-install, so move "docker pull" to post-install.

mkdir /share/Docker/Grafana
mkdir /share/Docker/Grafana/config
mkdir /share/Docker/Grafana/data

cfg='/share/Docker/Grafana/config/grafana.ini'
if [ ! -f $cfg ]; then
  cp grafana.ini /usr/share/docker/Grafana/config
fi
