#!/bin/bash

CONTAIN=redis
PASSWORD=123456

function run()
{
    A=docker ps -a | grep ${CONTAIN}

    if [[ -z ${A} ]] ; then
        echo "开始启动."
        docker run -dt --name ${CONTAIN} \
        --restart always \
        -v /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime \
        -p 6379:6379 \
        redis:5.0.10-alpine redis-server --bind 0.0.0.0 --requirepass ${PASSWORD}
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
