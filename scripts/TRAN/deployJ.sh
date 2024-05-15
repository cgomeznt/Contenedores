#!/bin/bash
name="credicard-paguetodo-jpos-prod"
file=/home/mrodrige/$name.tar.gz

sh /home/mrodrige/backupJ.sh &&
sh /home/mrodrige/build/jpos/build.sh &&
sh /home/mrodrige/load.sh &&
docker save $name:latest | gzip > $file &&
rsync -avz -P -I -e 'ssh' $file mrodrige@10.133.0.165:$file
rm $file
