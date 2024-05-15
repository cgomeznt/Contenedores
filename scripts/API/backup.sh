#!/bin/bash
name="credicard-paguetodo"
docker save $name:latest | gzip > /home/mrodrige/backup.tar.gz
