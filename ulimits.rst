Para Docker configurar los ulimits
====================================
  
To configure kernel limits for Docker contains, use the "default-ulimits" key in Docker daemon configuration file. 
The file has to be installed on Docker hosts at /etc/docker/daemon.json::

  {
    "default-ulimits": {
      "nofile": {
        "Name": "nofile",
        "Hard": 64000,
        "Soft": 64000
      }
    }
  }
