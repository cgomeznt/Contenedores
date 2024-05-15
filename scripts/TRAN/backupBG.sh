#!/bin/bash
name="credicard-paguetodo-bank-gateway-prod"
docker save $name:latest | gzip > /home/mrodrige/backupBG.tar.gz
