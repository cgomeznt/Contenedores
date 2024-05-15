#!/bin/bash

name=$1
if [ -z "$name" ]
  then
    name="app-proxy-prod-crd-pt"
fi

file=/home/mrodrige/$name.tar.gz

docker save $name:latest | gzip > $file &&
rsync -avz -P -I -e 'ssh' $file mrodrige@10.133.0.146:$file
rm $file
