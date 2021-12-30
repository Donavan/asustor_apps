#!/bin/sh

echo "post-install"

# App Central extend timeout, but the timeout seems be counted from post-install, not pre-install, so move "docker pull" to post-install.

docker pull grafana/grafana:8.3.3

echo "Completed docker pull"


CONTAINER_TEST=$(docker container ls -a | grep Grafana | awk '{print $1}')
\
if [ ! -z $CONTAINER_TEST ]; then
	docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=Grafana \
  -p 3000:3000 \
  -v "/share/Docker/Grafana/data:/var/lib/grafana" \
  -v "/share/Docker/Grafana/config/grafana.ini:/etc/grafana/grafana.ini" \
	--restart unless-stopped \
	grafana/grafana

case "$APKG_PKG_STATUS" in
	install)
		;;
	upgrade)
		oldim=$(docker images | grep grafana/grafana | grep none | awk '{print $3}')
		echo $oldim
		
		if [ ! -z $oldim ]; then 
			docker rmi -f $oldim
		fi
		;;
	*)
		;;
esac

exit 0
