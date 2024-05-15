#!/bin/bash

number=$1
if [ -z "$number" ]
  then
    number=100
fi
docker logs -f app-proxy-prod-crd-pt --tail $number

