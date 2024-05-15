#!/bin/bash
sh /home/mrodrige/backup.sh &&
sh /home/mrodrige/build/nginx/build.sh &&
sh /home/mrodrige/load.sh &&
sh /home/mrodrige/send.sh
