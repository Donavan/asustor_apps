#!/bin/sh

echo "start-stop"

CONTAINER_NAME=Grafana
 
case "$1" in
    start)
        echo "Start $CONTAINER_NAME container..."
        docker start $CONTAINER_NAME
        sleep 6 
                        
        ;;
    stop)
    	echo "Stop $CONTAINER_NAME container..."
    	docker stop $CONTAINER_NAME
    	sleep 6
        ;;
    reload)
    	echo "Reload $CONTAINER_NAME container..."
    	docker stop  $CONTAINER_NAME
    	sleep 3
    	docker start $CONTAINER_NAME
    	sleep 5
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
