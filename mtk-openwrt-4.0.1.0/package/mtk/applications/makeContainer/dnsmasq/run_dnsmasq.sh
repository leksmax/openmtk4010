#!/bin/sh
CMD_NAME=${0%.*}
CON_NAME=${CMD_NAME##*run_}

if [ -z "$2" ]; then
	ENV_ARGS="CON_NAME=$CON_NAME"
else
	ENV_ARGS="ARGS=$2"
fi

if [ -z "$3" ]; then
	CONTAINER_PATH=""
else
	CONTAINER_PATH=$3/
fi

docker run -d \
	--name "$CON_NAME"_$1 \
	-e "$ENV_ARGS" \
	-v /bin:/bin \
	-v /dev:/dev \
	-v /etc:/etc \
	-v /lib:/lib \
	-v /sbin:/sbin \
	-v /tmp:/tmp \
	-v /usr:/usr \
	-v /var:/var \
	--network host --privileged ${CONTAINER_PATH}$CON_NAME:$1
