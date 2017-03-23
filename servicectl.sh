#!/bin/bash

CONTAINER_NAME="mongodb-example"

function usage {
    "Usage: ${0##*/} {start|stop|restart}"
}

function start {
    docker run --name $CONTAINER_NAME \
        -d \
        -e "TZ=Asia/Seoul" \
	-e ES_JAVA_OPTS="-Xms1g -Xmx1g" \
        -p 27017:27017 \
	-v ${MONGO_HOME}/data:/data/db \
	mongo:3.4.2
}

function stop {
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
}

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

while [ "$#" -gt "0" ]
do
    case $1 in
        start)
            start
            ;;
        stop)
            stop
            ;;
        restart)
            stop
            start
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

