#!/bin/bash
name="credicard-paguetodo-bank-gateway-prod"
file=/home/mrodrige/$name.tar.gz

sh /home/mrodrige/backupBG.sh
sh /home/mrodrige/build/bank-gateway/build.sh &&
sh /home/mrodrige/load.sh &&
docker save $name:latest | gzip > $file &&
rsync -avz -P -I -e 'ssh' $file mrodrige@10.133.0.165:$file
rm $file
docker logs -f bank-gateway
