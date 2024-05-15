#!/bin/bash
name="credicard-paguetodo-jpos-merchant-prod"
docker save $name:latest | gzip > /home/mrodrige/backupJM.tar.gz
