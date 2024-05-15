#!/bin/bash
name="credicard-paguetodo-merchant-prod"
docker save $name:latest | gzip > /home/mrodrige/backupM.tar.gz
