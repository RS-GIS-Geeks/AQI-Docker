FROM python:3.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV LANG C.UTF-8
ENV TZ UTC
ENV DJANGO_REPO_URL https://github.com/RS-GIS-Geeks/AQI-Background.git
ENV DJANGO_REPO_BRANCH master

RUN echo "Installing packages ..." \
      # && sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list \
      # && sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y --no-install-recommends libgdal-dev git \
      && cd /opt \
      && git clone ${DJANGO_REPO_URL} -b ${DJANGO_REPO_BRANCH} AQI-Background \
      && cd AQI-Background \
      && ls -a -l \
      && pip install -r requirements.txt \
      && apt-get purge -y --auto-remove git \
      && rm -rf /var/lib/apt/lists/*

COPY docker-uwsgi-entrypoint.sh /docker-uwsgi-entrypoint.sh
COPY settings.py /opt/settings.py
COPY aqi_uwsgi.ini /opt/uwsgi.ini

RUN chmod +x /docker-uwsgi-entrypoint.sh

ENV PYTHONHOME /usr/local
ENV PYTHONPATH /usr/local/lib/python3.6

WORKDIR /opt/AQI-Background

VOLUME ["/opt/aqidjango/static" ,"/var/aqi/uwsgi-sock", "/var/aqi/logs"]

ENTRYPOINT ["/docker-uwsgi-entrypoint.sh"]

CMD ["uwsgi", "--ini", "uwsgi.ini"]
