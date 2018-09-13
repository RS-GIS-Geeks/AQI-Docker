#!/bin/bash
set -e

IMAGE_DIR=`dirname $0`

docker load -i ${IMAGE_DIR}/django/aqi-django.tar
docker load -i ${IMAGE_DIR}/nginx/aqi-nginx.tar
docker load -i ${IMAGE_DIR}/postgis/aqi-postgis.tar
