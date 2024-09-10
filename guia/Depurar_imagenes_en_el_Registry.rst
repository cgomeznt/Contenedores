Depurar imagenes en el Registry
===================================


Se debe ingresar al servidor de Registry.

Consultamos el contendor::

	$ sudo bash
	# docker ps
	CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                             NAMES
	0749eebd3277        registry:2          "/entrypoint.sh /e..."   4 years ago         Up 3 months         5000/tcp, 0.0.0.0:4443->443/tcp   registry


Nos vamos a esta ruta (puede variar))::

	# cd /var/lib/docker/volumes/b95921f94cc8e7170a9b4903d7de865ffe9bd845d55385456fb4ba71ccc54f59/_data/docker/registry/v2/repositories/

Listamos los directorios::

	# ls -ltr
	drwxr-xr-x 5 root root   55 Sep  9 09:40 ccr-pic-backend-pushnotification3409
	drwxr-xr-x 5 root root   55 Sep  9 10:17 ccr-pic-backend-pushnotification3410
	drwxr-xr-x 5 root root   55 Sep  9 10:32 ccr-pic-backend-pushnotification3411
	drwxr-xr-x 5 root root   55 Sep  9 10:39 app-backend3412
	drwxr-xr-x 5 root root   55 Sep  9 10:41 ccr-pic-backend-pushnotification3413
	drwxr-xr-x 5 root root   55 Sep  9 10:50 sggti-services3414
	drwxr-xr-x 5 root root   55 Sep  9 10:54 sggti-services3415
	drwxr-xr-x 5 root root   55 Sep  9 10:59 sggti-services3416
	drwxr-xr-x 5 root root   55 Sep  9 11:06 sggti-services3417
	drwxr-xr-x 5 root root   55 Sep  9 11:12 ccr-pic-backend-pushnotification3418
	drwxr-xr-x 5 root root   55 Sep  9 11:15 sggti-services3419
	drwxr-xr-x 5 root root   55 Sep  9 11:18 ccr-pic-backend-iseries3420
	drwxr-xr-x 5 root root   55 Sep  9 11:24 sggti-services3421
	drwxr-xr-x 5 root root   55 Sep  9 11:37 ccr-pic-backend-app3422
	drwxr-xr-x 5 root root   55 Sep  9 11:51 ccr-pic-frontend-auditoria3423
	drwxr-xr-x 5 root root   55 Sep  9 11:54 ccr-pic-backend-pushnotification3424
	drwxr-xr-x 5 root root   55 Sep  9 12:12 ccr-pic-backend-pushnotification3425
	drwxr-xr-x 5 root root   55 Sep  9 12:16 ccr-pic-backend-pushnotification3426
	drwxr-xr-x 5 root root   55 Sep  9 12:22 ccr-pic-backend-pushnotification3427
	drwxr-xr-x 5 root root   55 Sep  9 12:33 sggti-services3428
	drwxr-xr-x 5 root root   55 Sep  9 14:16 ccr-pic-backend-pushnotification3429
	drwxr-xr-x 5 root root   55 Sep  9 14:21 ccr-pic-backend-pushnotification3430
	drwxr-xr-x 5 root root   55 Sep  9 14:24 ccr-pic-backend-pushnotification3431
	drwxr-xr-x 5 root root   55 Sep  9 14:30 ccr-pic-backend-iseries3432
	drwxr-xr-x 5 root root   55 Sep  9 14:31 ccr-pic-backend-pushnotification3433
	drwxr-xr-x 5 root root   55 Sep  9 14:50 ccr-pic-backend-pushnotification3434
	drwxr-xr-x 5 root root   55 Sep  9 14:55 app-backend3435
	drwxr-xr-x 5 root root   55 Sep  9 15:10 app-backend3436
	drwxr-xr-x 5 root root   55 Sep  9 15:15 app-backend3437
	drwxr-xr-x 5 root root   55 Sep  9 15:21 ccr-pic-backend-pushnotification3438
	drwxr-xr-x 5 root root   55 Sep  9 15:23 app-backend3439
	drwxr-xr-x 5 root root   55 Sep  9 15:24 ccr-pic-backend-pushnotification3440
	drwxr-xr-x 5 root root   55 Sep  9 15:24 sggti-services3441
