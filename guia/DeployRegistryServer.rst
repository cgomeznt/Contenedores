Deploy a Registry Server
=======================

https://docs.docker.com/registry/deploying/

**Run a local registry** Usar el siguiente comando para instanciar un contenedor de registry::

	$ docker run -d -p 5000:5000 --restart=always --name registry registry:2

Pull the ubuntu:16.04 image from Docker Hub.::

	$ docker pull ubuntu:16.04

Tag the image as localhost:5000/my-ubuntu. This creates an additional tag for the existing image. When the first part of the tag is a hostname and port, Docker interprets this as the location of a registry, when pushing.::

	$ docker tag ubuntu:16.04 localhost:5000/my-ubuntu

Push the image to the local registry running at localhost:5000::

	$ docker push localhost:5000/my-ubuntu

Remove the locally-cached ubuntu:16.04 and localhost:5000/my-ubuntu images, so that you can test pulling the image from your registry. This does not remove the localhost:5000/my-ubuntu image from your registry.::

	$ docker image remove ubuntu:16.04
	$ docker image remove localhost:5000/my-ubuntu

Crear un Registry con SSL
------------------------------

Construimos el directorio de trabajo::

	mkdir /certs && cd /certs

Creamos el archivo ssl.conf::

	echo "# Self Signed (note the addition of -x509):
	#     openssl req -config example-com.conf -new -x509 -sha256 -newkey rsa:2048 -nodes -keyout example-com.key.pem -days 365 -out example-com.cert.pem
	# Signing Request (note the lack of -x509):
	#     openssl req -config example-com.conf -new -newkey rsa:2048 -nodes -keyout example-com.key.pem -days 365 -out example-com.req.pem
	# Print it:
	#     openssl x509 -in example-com.cert.pem -text -noout
	#     openssl req -in example-com.req.pem -text -noout
	
	[ req ]
	default_bits        = 4096
	default_keyfile     = server-key.pem
	distinguished_name  = subject
	req_extensions      = req_ext
	x509_extensions     = x509_ext
	string_mask         = utf8only
	# The Subject DN can be formed using X501 or RFC 4514 (see RFC 4519 for a description).
	#   Its sort of a mashup. For example, RFC 4514 does not provide emailAddress.
	[ subject ]
	countryName         = VE
	countryName_default = VE
	stateOrProvinceName = DC
	stateOrProvinceName_default = CCS
	organizationUnit    = CCR
	organizationUnit_default    = TEC
	
	localityName        = CCS
	localityName_default = CCS
	
	organizationName     = CCR
	organizationName_default  = CCR
	
	# Use a friendly name here because its presented to the user. The server's DNS
	#   names are placed in Subject Alternate Names. Plus, DNS names here is deprecated
	#   by both IETF and CA/Browser Forums. If you place a DNS name here, then you
	#   must include the DNS name in the SAN too (otherwise, Chrome and others that
	#   strictly follow the CA/Browser Baseline Requirements will fail).
	commonName         = Registry
	commonName_default = Registry
	
	emailAddress       = info@credicard.com.ve
	emailAddress_default  = info@credicard.com.ve
	
	# Section x509_ext is used when generating a self-signed certificate. I.e., openssl req -x509 ...
	#  If RSA Key Transport bothers you, then remove keyEncipherment. TLS 1.3 is removing RSA
	#  Key Transport in favor of exchanges with Forward Secrecy, like DHE and ECDHE.
	[ x509_ext ]
	
	subjectKeyIdentifier    = hash
	authorityKeyIdentifier  = keyid,issuer
	
	basicConstraints        = CA:FALSE
	keyUsage            = digitalSignature, keyEncipherment
	subjectAltName      = IP:10.134.4.250
	nsComment           = "OpenSSL Generated Certificate"
	
	# RFC 5280, Section 4.2.1.12 makes EKU optional
	# CA/Browser Baseline Requirements, Appendix (B)(3)(G) makes me confused
	# extendedKeyUsage  = serverAuth, clientAuth
	
	# Section req_ext is used when generating a certificate signing request. I.e., openssl req ...
	[ req_ext ]
	
	subjectKeyIdentifier    = hash
	
	basicConstraints    = CA:FALSE
	keyUsage            = digitalSignature, keyEncipherment
	subjectAltName      = IP:10.134.4.250
	nsComment           = "OpenSSL Generated Certificate"
	
	# RFC 5280, Section 4.2.1.12 makes EKU optional
	# CA/Browser Baseline Requirements, Appendix (B)(3)(G) makes me confused
	# extendedKeyUsage  = serverAuth, clientAuth
	
	[ alternate_names ]
	
	DNS.1       = example.com
	DNS.2       = www.example.com
	DNS.3       = mail.example.com
	DNS.4       = ftp.example.com" > ssl.conf

Creamos el certificado autofirmado::

	openssl req -newkey rsa:4096 -nodes -sha256  -keyout domain.key  -x509 -days 10000 -out domain.crt  -config ssl.conf

Listamos los archivos::

	ls -ltr
	total 12
	-rw-r----- 1 root root 3028 Apr 23 10:39 ssl.conf
	-rw------- 1 root root 3272 Apr 23 10:41 domain.key
	-rw-r----- 1 root root 2110 Apr 23 10:41 domain.crt

Preparamos el directorio para que el Registry sea accesible desde su mismo host::

	mkdir -p /etc/docker/certs.d/10.134.4.250:4443

	cp domain.crt /etc/docker/certs.d/10.134.4.250:4443/ca.crt

Culminamos haciendo la descarga de una imagen y haciendo el push dentro del Registry::

	docker pull alpine

	docker tag alpine:latest 10.134.4.250:4443/alpine

	docker images

	docker push 10.134.4.250:4443/alpine

Correr un Registry accesible desde otros servidores
+++++++++++++++++++++++++++++++++++++

Correr el registry  de forma insegura es solo accesible desde localhost. Para poder crear un registry accesible desde host externos, debemos configurar primero los TLS.

Debemos crear los certificados primero con **openssl**, creamos un directorio de trabajo::

	mkdir certs
	cd certs

Ahora sigue este procedimiento de crear un certificado auto firmado. Este procedimiento lo debemos crear en el Host. Poner atención cuando en la creación del Request (crs) consulten <Common Name (e.g. server FQDN or YOUR name)> aquí se debe especificar el nombre correcto del servidor a nivel de DNS o el nombre que se utilizara en los archivos HOSTS. En este ejemplo debe ser registry.dominio.local

https://github.com/cgomeznt/openssl/blob/master/guia/Autofirmado.rst


Luego que tengamos los certificados los debemos crear una carpeta en los servidores que vayan a utilizar el Docker Registry::

	mkdir -p /etc/docker/certs.d/NOMBRE_DEL_CONTENEDOR\:PUERTO/

	mkdir -p /etc/docker/certs.d/registry.dominio.local\:4443/

Y dentro de esa carpeta debemos copiar el certificado del servidor y la CA que lo firmo::

	cp registry.crt rootCA.crt /etc/docker/certs.d/NOMBRE_DEL_CONTENEDOR\:PUERTO/

	cp registry.crt rootCA.crt /etc/docker/certs.d/registry.dominio.local\:4443/

**NOTA** Si omites los pasos anteriores te encontraras con este error <Get https://registry.dominio.local:4443/v2/: x509: certificate signed by unknown authority
>
Se instancia el contenedor de Registry, debemos estar un peldaño sobre la carpeta certs, donde están los certificados::

	docker run -d \
	  --restart=always \
	  --name registry.dominio.local \
	  -v "$(pwd)"/certs:/certs \
	  -e REGISTRY_HTTP_ADDR=0.0.0.0:4443 \
	  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
	  -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
	  -p 4443:4443 \
	  --network app \
	  registry:2

Consultamos que IP tiene::

	docker container inspect registry.dominio.local | grep IPAddress

La IP que nos arroje se la cargamos a nuestro archivo HOST en donde esta corriendo el contenedor::

	echo "172.18.0.3	registry.dominio.local" >> /etc/hosts

Probamos desde el HOST el ping::

	ping -c2 registry.dominio.local

Vemos que imágenes tiene el Registry::

	curl -k https://registry.dominio.local:4443/v2/_catalog


descargamos una imagen de prueba::

	docker pull alpine

	docker tag alpine:latest registry.dominio.local:4443/alpine

	docker images

	docker push registry.dominio.local:4443/alpine

Volvemos a verificar que imágenes tiene el Registry::

	curl -k https://registry.dominio.local:4443/v2/_catalog

Listo ...!!!
