#!/bin/bash
DIR=/home/mrodrige
name="app-proxy-prod-crd-pt"
file=$name.tar.gz
docker save $name:latest | gzip > $DIR/backup.tar.gz
