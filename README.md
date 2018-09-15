
[![Build Status](https://travis-ci.com/RS-GIS-Geeks/AQI-Docker.svg?branch=master)](https://travis-ci.com/RS-GIS-Geeks/AQI-Docker)
[![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# 空气污染数据可视化系统 - Docker 部署方案

> AQI Data Visualization System - Deploy Solution by Docker-compose

## 项目结构

- 项目地址：[https://github.com/RS-GIS-Geeks/AQI-Docker](https://github.com/RS-GIS-Geeks/AQI-Docker)

- 镜像仓库:
  - [cstao/aqi-postgis](https://store.docker.com/community/images/cstao/aqi-postgis)
  - [cstao/aqi-django](https://store.docker.com/community/images/cstao/aqi-django)
  - [cstao/aqi-nginx](https://store.docker.com/community/images/cstao/aqi-nginx)

## 编排命令

- 构建镜像

  本地构建：
  ```bash
  docker-compose build
  ```
  或者从 [store.docker.com](https://store.docker.com/profiles/cstao) 拉取：
  ```bash
  docker-compose pull
  ```

- 创建并启动服务

  同步：
  ```bash
  docker-compose up
  ```
  异步：
  ```bash
  docker-compose up -d
  ```

- 导入数据到 postgresql 数据库

  利用 `docker ps` 命令得到 `postgis` 容器的 `ID`，然后在 `postgis` 容器中执行导入数据的命令(`pg_dumped_data-url` 应该替换为自定义的 sql 数据的 URL，如果不指定该参数，则默认使用 `https://github.com/RS-GIS-Geeks/AQI-Docker/releases/download/v1.0.0/aqidb.sql` 作为源数据)：
  ```bash
  docker exec -i <postgis-container-id> import_data [pg_dumped_data-url]
  ```

- 更新后台服务

  ```bash
  docker exec -i <django-container-id> update_django
  ```

- 更新网站

  ```bash
  docker exec -i <nginx-container-id> update_website
  ```

- 启动/停止/重启服务

  启动：
  ```bash
  docker-compose start
  ```
  停止：
  ```bash
  docker-compose stop
  ```
  重启：
  ```bash
  docker-compose restart
  ```

- 暂停/恢复服务

  暂停：
  ```bash
  docker-compose pause
  ```
  恢复：
  ```bash
  docker-compose unpause
  ```

- 停止并移除由 `docker-compose.yml` 定义的服务容器和网络
  ```bash
  docker-compose down [--rmi <all>|<local>] [-v|--volume]
  ```

  - 添加 `--rmi type` 参数可以移除镜像，`tpye` 可以为 `all` 或 `local`，`all` 表示移除所有镜像，`local` 表示只移除没有定义标签的镜像
  - 添加 `-v` 或 `--volume` 参数可以移除所有在 `docker-compose.yml` 中定义的数据卷

## Maintainer

  | [<img src="https://avatars2.githubusercontent.com/u/22360632?s=400&u=1e8c0b49ed6ee28a1911f69d29176fd918c54897&v=4" width="100px;"/><br /><sub><b>CS-Tao</b></sub>](https://github.com/CS-Tao) | 
  | :---: |
