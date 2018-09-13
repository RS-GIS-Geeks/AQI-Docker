#!/bin/bash
set -e

if [ ! -d "/var/aqi/logs/nginx/" ];then
    mkdir /var/aqi/logs/nginx
else
    echo "Directory '/var/aqi/logs/nginx' has already existed."
fi

/usr/local/bin/django_check.sh
/usr/local/bin/start_nginx.sh

exec "$@";
