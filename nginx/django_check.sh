#!/bin/bash
set -e

while [ "`ls -A /var/aqi/django-sock`" = "" ]; do
    echo "Waiting for django to be online..."
    sleep 5s
done

