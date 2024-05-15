#!/bin/bash

TAIL=$1
if [ -z "$TAIL" ]
  then
    TAIL=200
fi

docker logs -f credicard-paguetodo-prod --tail $TAIL
