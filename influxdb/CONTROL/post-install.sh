#!/bin/sh

echo "post-install"

# App Central extend timeout, but the timeout seems be counted from post-install, not pre-install, so move "docker pull" to post-install.

docker pull docker pull influxdb:2.1.1

echo "Completed docker pull"


CONTAINER_TEST=$(docker container ls -a | grep InfluxDB | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
	docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=InfluxDB \
	-p 8086:8086 \
	-v /share/Docker/InfluxDB/data:/var/lib/influxdb2 \
	-v /share/Docker/InfluxDB/config/config.yml:/etc/influxdb2/config.yml \
	--restart unless-stopped \
	--net=influxdb \
	influxdb:2.1.1

#docker start Transmission


case "$APKG_PKG_STATUS" in
	install)
	  docker run --rm influxdb:2.1.1 influxd print-config > /share/Docker/InfluxDB/config/config.yml
		;;
	upgrade)
		oldim=$(docker images | grep infuxdb | grep none | awk '{print $3}')
		echo $oldim
		
		if [ ! -z $oldim ]; then 
			docker rmi -f $oldim
		fi
		;;
	*)
		;;
esac

exit 0
