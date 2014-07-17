#!/usr/bin/env bash

docker_cmd=`which docker`

app_image='stack/flask-app'
app_cid='./run/app.cid'

if [ ! -d run ]; then
    mkdir run;
fi
db_image='stack/db'
db_cid='./run/db.cid'
