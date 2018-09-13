#!/bin/bash
set -e

if [ ! -d "/var/aqi/logs/nginx/" ];then
    mkdir /var/aqi/logs/nginx
else
    echo "Directory '/var/aqi/logs/nginx' has already existed."
fi

sed -i "s?AQI_STATIC_FOLDER?/usr/share/nginx/html/aqi-visualization/${WEB_FOLDER}?" /etc/nginx/conf.d/default.conf \

/usr/local/bin/django_check.sh
/usr/local/bin/start_nginx.sh

exec "$@";
