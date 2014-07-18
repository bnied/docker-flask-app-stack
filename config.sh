#!/usr/bin/env bash

docker_cmd=`which docker`
run_dir='./run'
if [ ! -d $run_dir ]; then
    mkdir $run_dir;
fi

flask_app_name='flask-app'
flask_app_image="stack/$flask_app_name"
flask_app_cid="./$run_dir/$flask_app_name"

node_app_name='node-app'
node_app_image="stack/$node_app_name"
node_app_cid="./$run_dir/$node_app_name"

db_name='app-db'
db_image="stack/$db_name"
db_cid="./$run_dir/$db_name"
