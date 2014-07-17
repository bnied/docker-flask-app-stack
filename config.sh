#!/usr/bin/env bash

docker_cmd=`which docker`
run_dir='./run'
if [ ! -d $run_dir ]; then
    mkdir $run_dir;
fi

app_name='flask-app'
app_image="stack/$app_name"
app_cid="./$run_dir/$app_name"


db_name='flask-db'
db_image="stack/$db_name"
db_cid="./$run_dir/$db_name"
