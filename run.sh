#!/bin/bash

. config.sh

function startDb() {
  if [ -f $db_cid ]; then
      echo "db already running"
      exit 1
  fi
  $docker_cmd run --name flask-db -d --cidfile=$db_cid -p 0.0.0.0:5432:5432 $db_image
}


function stopDb() {
    if [ ! -f $db_cid ]; then
        echo "db stopped"
        exit 0
    fi
    docker stop $(cat $db_cid) && docker rm $db_name
    rm $db_cid
}

function startApp() {
  if [ -f $app_cid ]; then
      echo "App already running"
      exit 1
  fi
  $docker_cmd run --name $app_name --link $db_name:db -d --cidfile=$app_cid -p 0.0.0.0:8000:8000 $app_image python /app/bin/run --debug
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
    startDb
    startApp
}

function stop() {
    stopDb
    stopApp
}

function restart() {
    stop
    start
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
    echo "          restart     Restart the whole shebang"
    echo "          startApp    Starts up the application only"
    echo "          stopApp     Stops the application only"
    echo "          startDb     Starts up the database only"
    echo "          stopDb      Stops the database only"
}


case $1 in
    start)
        start;;
    stop)
        stop;;
    status)
        status;;
    restart)
        restart;;
    startApp)
        startApp;;
    stopApp)
        stopApp;;
    startDb)
        startDb;;
    stopDb)
        stopDb;;
    *)
        usage
        exit 1
    ;;

esac
