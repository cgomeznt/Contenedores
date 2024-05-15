#!/bin/bash
name="credicard-paguetodo-jpos-prod"
docker save $name:latest | gzip > /home/mrodrige/backupJ.tar.gz
