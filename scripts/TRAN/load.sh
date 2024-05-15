#!/bin/bash
docker-compose -f /home/mrodrige/docker-compose.yml up -d --no-deps --build
docker image prune -f
