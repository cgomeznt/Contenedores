#!/bin/bash
DIR="/home/mrodrige"
name="credicard-paguetodo"
file=$DIR/$name.tar.gz
docker save $name:latest | gzip > $DIR/backup.tar.gz
#docker load < $file && rm $file
docker load < $file
docker-compose -f /home/mrodrige/docker-compose.yml up -d --no-deps --build
#docker image prune -f
docker logs -f credicard-paguetodo-prod --tail 100
