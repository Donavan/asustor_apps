#!/bin/sh

echo "post-install"

# App Central extend timeout, but the timeout seems be counted from post-install, not pre-install, so move "docker pull" to post-install.

docker pull telegraf:1.21.1

echo "Completed docker pull"


CONTAINER_TEST=$(docker container ls -a | grep Telegraf | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
	docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=Telegraf \
	--net=influxdb \
  -p 8125:8125/udp \
  -p 8092:8092/udp \
  -p 8094:8094 \
  -v /share/Docker/Telegraf/config/telegraf.conf:/etc/telegraf/telegraf.conf:ro \
	--restart unless-stopped \
	telegraf

case "$APKG_PKG_STATUS" in
	install)
		;;
	upgrade)
		oldim=$(docker images | grep telegraf | grep none | awk '{print $3}')
		echo $oldim
		
		if [ ! -z $oldim ]; then 
			docker rmi -f $oldim
		fi
		;;
	*)
		;;
esac

exit 0
