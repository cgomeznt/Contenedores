Que es local Pago
===================


Esta creado con docker compose

# docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
local-com.ve   latest              6977a64682a3        4 months ago        456MB

# cat docker-compose.yml
version: '3'
services:
  pis:
    container_name: local-com.ve-prod
    image: local-com.ve:latest
    command:  java -Xms2048m -Xmx2048m -Djava.awt.headless=true -Dcom.ibm..access..guiAvailable=false -Dhttp.proxyHost=10.10.10.1 -Dhttp.proxyPort=8080 -Dhttps.proxyHost=10.10.10.1 -Dhttps.proxyPort=8080 -jar local-com.ve.jar server config.yml prod true
    # command:  java -Djava.awt.headless=true -Dcom.ibm.as400.access.AS400.guiAvailable=false -jar local-com.ve.jar server config.yml prod true
    restart: always
    network_mode: "host"
    extra_hosts:
      - "pis.local.com.ve:10.10.10.42"
    ports:
      - "29436:29436"
      - "8443:8443"
    volumes:
      - /pissis/log:/usr/app/log/
      - /pissis/Entrada/:/usr/app/Entrada/

# cat restart.sh
#!/bin/bash
docker-compose -f /home/tu_user/docker-compose.yml restart

# cat backup.sh
#!/bin/bash
name="local-com.ve"
docker save $name:latest | gzip > /home/tu_user/backup.tar.gz

# cat backup.sh
#!/bin/bash
name="local-com.ve"
docker save $name:latest | gzip > /home/tu_user/backup.tar.gz
[root@pisserver1 bin]# cat load.sh
#!/bin/bash
docker-compose -f /home/tu_user/docker-compose.yml up -d --no-deps --build
docker image prune -f

# cat rollback.sh
#!/bin/bash
DIR="/home/tu_user"
name="backup"
file=$DIR/$name.tar.gz
docker load < $file
docker-compose -f /home/tu_user/docker-compose.yml up -d --no-deps --build
docker image prune -f
docker logs -f local-com.ve-prod --tail 100

# cat full-load.sh
#!/bin/bash
DIR="/home/tu_user"
name="local-com.ve"
file=$DIR/$name.tar.gz
docker save $name:latest | gzip > $DIR/backup.tar.gz
docker load < $file && rm $file
docker-compose -f /home/tu_user/docker-compose.yml up -d --no-deps --build
docker image prune -f
docker logs -f local-com.ve-prod --tail 100

# cat logs.sh
#!/bin/bash
docker logs -f local-com.ve-prod --tail 100

pisserver1
172.16.0.1
172.26.0.1
10.10.10.1 
