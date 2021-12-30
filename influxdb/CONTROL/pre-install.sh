#!/bin/sh

echo "pre-install"
docker network create influxdb
mkdir /share/Docker/InfluxDB
mkdir /share/Docker/InfluxDB/config
mkdir /share/Docker/InfluxDB/data

