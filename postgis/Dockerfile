FROM postgres:9.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV PG_DUMPED_DATA_DEFAULT_URL https://github.com/RS-GIS-Geeks/AQI-Docker/releases/download/v1.0.0/aqidb.sql

ENV POSRGRESQL_MAJOR 9.6

ENV POSTGIS_MAJOR 2.4

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
      && apt-get install -y --no-install-recommends \
            postgis \
            postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR} \
            postgresql-${POSRGRESQL_MAJOR}-postgis-scripts \
      && rm -rf /var/lib/apt/lists/*

COPY create_role.sh /docker-entrypoint-initdb.d/10-create_role.sh
COPY init_db.sh /docker-entrypoint-initdb.d/20-init_db.sh
COPY import_data /usr/local/bin/import_data
COPY _import_data /usr/local/bin/_import_data

RUN   chmod 755 /docker-entrypoint-initdb.d/10-create_role.sh \
      && chmod 755 /docker-entrypoint-initdb.d/20-init_db.sh \
      && chmod +x /usr/local/bin/_import_data \
      && chmod +x /usr/local/bin/import_data \
      && chown -R postgres:postgres /usr/local/bin

VOLUME ["/var/lib/postgresql/data", "/var/aqi/logs"]
