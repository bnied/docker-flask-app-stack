#!/bin/bash

. config.sh
while getopts "c" flag
do
    case "$flag" in
        c) clean=1;echo "Running Clean";;
    esac
done

if [[ $clean -gt 0 ]]; then
    echo "Removing images before rebuilding"
    $docker_cmd rmi $flask_app_image 
    $docker_cmd rmi $node_app_image 
    $docker_cmd rmi $db_image 
fi

$docker_cmd build -t $flask_app_image ./flask-app
$docker_cmd build -t $node_app_image ./node-app
$docker_cmd build -t $db_image ./db
