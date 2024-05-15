#!/bin/bash
DIR="/home/mrodrige"
name="backup"
file=$DIR/$name.tar.gz
docker load < $file
docker-compose -f /home/mrodrige/docker-compose.yml up -d --no-deps --build
docker image prune -f
docker logs -f credicard-paguetodo-prod --tail 100
