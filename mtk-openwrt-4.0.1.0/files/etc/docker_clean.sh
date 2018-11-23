#!/bin/sh

echo ""
echo " *********************************************************** "
echo " Docker Clean Up   "
echo " *********************************************************** "

cd /www/openAPgent;python -m utils/docker_image_container_clean_up

echo "*********************** Cleanup Done *********************** "

docker images

docker ps -a

echo "************************************************************ "
