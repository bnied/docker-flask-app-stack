#!/bin/bash

. config.sh

function startDb() {
  if [ -f $db_cid ]; then
      echo "app-db already running"
      exit 1
  fi
  $docker_cmd run --name app-db -d --cidfile=$db_cid -p 0.0.0.0:5432:5432 $db_image
}


function stopDb() {
    if [ ! -f $db_cid ]; then
        echo "db stopped"
        exit 0
    fi
    docker stop $(cat $db_cid) && docker rm $db_name
    rm $db_cid
}

function startFlaskApp() {
  if [ -f $flask_app_cid ]; then
      echo "Flask App already running"
      exit 1
  fi
  $docker_cmd run --name $flask_app_name --link $db_name:db -d --cidfile=$flask_app_cid -p 0.0.0.0:8000:8000 $flask_app_image python /app/bin/run --debug
}


function stopFlaskApp() {
    if [ ! -f $flask_app_cid ]; then
        echo "Flask App stopped"
        exit 0
    fi
    docker stop $(cat $flask_app_cid) && docker rm $flask_app_name
    rm $flask_app_cid
}

function startNodeApp() {
  if [ -f $node_app_cid ]; then
      echo "Node App already running"
      exit 1
  fi
  $docker_cmd run --name $node_app_name --link $db_name:db -d --cidfile=$node_app_cid -p 0.0.0.0:3000:3000 $node_app_image
}


function stopNodeApp() {
    if [ ! -f $node_app_cid ]; then
        echo "Node App stopped"
        exit 0
    fi
    docker stop $(cat $node_app_cid) && docker rm $node_app_name
    rm $node_app_cid
}

function start() {
    startDb
    startFlaskApp
    startNodeApp
}

function stop() {
    stopDb
    stopFlaskApp
    stopNodeApp
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
    echo "          startFlaskApp    Starts up the flask application only"
    echo "          stopFlaskApp     Stops the flask application only"
    echo "          startNodeApp    Starts up the node application only"
    echo "          stopNodeApp     Stops the node application only"
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
    startFlaskApp)
        startFlaskApp;;
    stopFlaskApp)
        stopFlaskApp;;
    startNodeApp)
        startNodeApp;;
    stopNodeApp)
        stopNodeApp;;
    startDb)
        startDb;;
    stopDb)
        stopDb;;
    *)
        usage
        exit 1
    ;;

esac
