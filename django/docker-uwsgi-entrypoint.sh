#!/bin/bash
set -e

cp /opt/settings.py /opt/AQI-Background/server/settings.py
cp /opt/uwsgi.ini /opt/AQI-Background/uwsgi.ini

if [ ! -d "/var/aqi/logs/django-uwsgi/" ];then
    mkdir /var/aqi/logs/django-uwsgi
else
    echo "Directory '/var/aqi/logs/django-uwsgi' has already existed."
    if [ ! -f "/data/filename" ];then
        touch /var/aqi/logs/django-uwsgi/aqi_uwsgi.log
    else
        echo "File '/var/aqi/logs/django-uwsgi/aqi_uwsgi.log' has already existed."
    fi
fi

cat >> /opt/AQI-Background/server/settings.py << EOF

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'NAME': '$POSTGRES_DB',
        'USER': '$POSTGRES_USER_FOR_DB',
        'HOST': '$POSTGRES_HOST',
        'PORT': '$POSTGRES_PORT',
        'PASSWORD': '$POSTGRES_PASSWD_FOR_USER',
    }
}

EOF

rm -rf /opt/aqidjango/static/*

# python manage.py migrate

python manage.py collectstatic

# python manage.py runserver 0.0.0.0:8080

exec "$@";
