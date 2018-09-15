FROM python:3.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV LANG C.UTF-8
ENV TZ UTC
ENV DJANGO_REPO_URL https://github.com/RS-GIS-Geeks/AQI-Background.git
ENV DJANGO_REPO_BRANCH docker

RUN echo "Installing packages ..." \
      # <切换 apt 中国源>
      # && echo 'deb http://mirrors.ustc.edu.cn/debian stretch main contrib non-free' > /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian stretch main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb http://mirrors.ustc.edu.cn/debian stretch-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian stretch-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb http://mirrors.ustc.edu.cn/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list \
      # </切换 apt 中国源>
      && apt-get update \
      && apt-get install -y --no-install-recommends libgdal-dev git \
      && cd /opt \
      && git clone ${DJANGO_REPO_URL} -b ${DJANGO_REPO_BRANCH} AQI-Background \
      && cd AQI-Background \
      && git log -n1 \
      && ls -a -l \
      # <切换 pip 中国源>
      # && mkdir -p ~/.pip/ \
      # && echo '[global]' > ~/.pip/pip.conf \
      # && echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple' >> ~/.pip/pip.conf \
      # && echo '[install]' >> ~/.pip/pip.conf \
      # && echo 'trusted-host = pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf \
      # </切换 pip 中国源>
      && pip install -r requirements.txt \
      && apt-get purge -y --auto-remove git \
      && rm -rf /var/lib/apt/lists/*

COPY docker-uwsgi-entrypoint.sh /docker-uwsgi-entrypoint.sh
COPY settings.py /opt/settings.py
COPY aqi_uwsgi.ini /opt/uwsgi.ini
COPY update_django /usr/local/bin/update_django

RUN chmod +x /docker-uwsgi-entrypoint.sh \
      && chmod +x /usr/local/bin/update_django

ENV PYTHONHOME /usr/local
ENV PYTHONPATH /usr/local/lib/python3.6

WORKDIR /opt/AQI-Background

VOLUME ["/opt/aqidjango/static" ,"/var/aqi/uwsgi-sock", "/var/aqi/logs"]

ENTRYPOINT ["/docker-uwsgi-entrypoint.sh"]

CMD ["uwsgi", "--ini", "uwsgi.ini"]
