#!/usr/bin/env sh
mkdir build
cp -Rp influxdb build/
sudo python apkg-tools/apkg-tools_py2.py create build/influxdb
cp -Rp telegraf build/
sudo python apkg-tools/apkg-tools_py2.py create build/telegraf
cp -Rp grafana build/
sudo python apkg-tools/apkg-tools_py2.py create build/grafana
sudo rm -Rf build/
sudo chmod a+rw *.apk
cp *.apk releases/
rm *.apk