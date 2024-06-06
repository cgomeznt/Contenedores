Configurar Docker detrás de un PROXY
==========================================

Crear el archivo con el siguiente contenido::

	# vi /etc/systemd/system/docker.service.d/http-proxy.conf
	[Service]
	Environment="HTTP_PROXY=http://10.132.0.10:8080/"
	Environment="HTTPS_PROXY=http://10.132.0.10:8080/"
	Environment="NO_PROXY=localhost,127.0.0.0/8,docker-registry.somecorporation.com"

Aplicamos el reload del demonio systemctl::

	# systemctl daemon-reload

Reiniciamos el docker::

	# systemctl restart docker

Ahora si podemos descargar una imagen desde Docker HUB::

	# docker pull  httpd