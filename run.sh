#!/bin/bash

. config.sh

function startApp() {
  if [ -f $app_cid ]; then
      echo "App already running"
      exit 1
  fi
  $docker_cmd run --name flask-app -d --cidfile=$app_cid -p 0.0.0.0:8000:8000 $app_image python /app/bin/run --debug
}


function stopApp() {
    if [ ! -f $app_cid ]; then
        echo "App stopped"
        exit 0
    fi
    docker stop $(cat $app_cid) && docker rm $app_name
    rm $app_cid
}

function start() {
    startApp
}

function stop() {
    stopApp
}

function status() {
    if [ -f $app_cid ]; then
        echo "App:  "$(cat $app_cid)
    else
        echo "App:  not running"
        return
    fi
}

function usage() {
    echo "Usage:    `basename $0` <action>"
    echo
    echo "ex:       `basename $0` start"
    echo
    echo "Actions:  start       start up a grid with 3 nodes"
    echo "          stop        tear down whatever is running"
    echo "          status      list running container types and their ids"
    echo "          startApp    Starts up the application only"
}


case $1 in
    start)
        start;;
    stop)
        stop;;
    status)
        status;;
    startApp)
        startApp;;
    *)
        usage
        exit 1
    ;;

esac
