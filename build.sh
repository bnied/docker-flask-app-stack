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
    $docker_cmd rmi $app_image 
    $docker_cmd rmi $db_image 
fi

$docker_cmd build -t $app_image ./app
$docker_cmd build -t $db_image ./db
