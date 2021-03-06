#!/bin/bash

CONTAIN=mysql
PASSWORD=123456
DBNAME=fidodb

function run()
{
    A=docker ps -a | grep ${CONTAIN}

    if [[ -z ${A} ]] ; then
        echo "开始启动."
        docker run -dt --name mysql \
        --restart always \
        --user mysql \
        -e TZ=Asia/Shanghai \
        -e MYSQL_ROOT_PASSWORD=${PASSWORD} \
        -e MYSQL_USER=fido \
        -e MYSQL_PASSWORD=${PASSWORD} \
        -e MYSQL_DATABASE=${DBNAME} \
        -p 3306:3306 \
        mysql:5.7 --defaults-file=/etc/mysql/mysql.conf.d/mysqld.cnf --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
    else
        echo "容器已经存在,退出"
    fi
}

function ps()
{
    echo "当前运行容器"
    docker ps -a | grep ${CONTAIN}
}


function stop()
{
    echo "停止当前容器"
    docker rm -f ${CONTAIN}
}

case $1 in
    -h) echo "run启动, stop停止, ps查看";;
    ps) ps;;
    run) run;;
    stop) stop;;
    *) echo "error: no such option $1.-h for help";;
esac
