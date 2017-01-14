[![Travis](https://img.shields.io/docker/pulls/pdnsadmin/pdnsadmin.svg?style=flat-square)]()
[![Travis](https://img.shields.io/docker/stars/pdnsadmin/pdnsadmin.svg?style=flat-square)]()
[![Travis](https://img.shields.io/travis/pdnsadmin/pdnsadmin.svg?style=flat-square)]()
[![GitHub issues](https://img.shields.io/github/issues/pdnsadmin/pdnsadmin-docker.svg?style=flat-square)](https://github.com/pdnsadmin/pdnsadmin-docker/issues)

## Introduction
This is a Dockerfile to build a container image for pdnsadmin which combines nginx, php-fpm and full latest pdnsadmin's source code.
We try to make it simplest and easiest to use for Users.

### Git repository
The source files for this project can be found here: [https://github.com/pdnsadmin/pdnsadmin-docker](https://github.com/pdnsadmin/pdnsadmin-docker)

If you have any improvements please submit a pull request.

### Docker hub repository
The Docker hub build can be found here: [https://registry.hub.docker.com/u/pdnsadmin/pdnsadmin]
## Versions
| Tag | Nginx | PHP | Alpine |
|-----|-------|-----|--------|
| latest | 1.10.2 | 7.0.14 | 3.5 |


## Building from source
To build from source you need to clone the git repo and run docker build:
```
git clone https://github.com/pdnsadmin/pdnsadmin-docker.git
docker build -t pdnsadmin:latest .
```

## Pulling from Docker Hub
```
docker pull pdnsadmin/pdnsadmin
```

## Running
To simply run the container:
```
sudo docker run -d pdnsadmin/pdnsadmin
```

You can then browse to ```http://<DOCKER_HOST>``` to view the default install files. To find your ```DOCKER_HOST``` use the ```docker inspect``` to get the IP address.
```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <CONTAINER_NAME>
```


### Custom Nginx Config files
Sometimes you need a custom config file for nginx to achieve this read the [Nginx config guide](https://github.com/pdnsadmin/pdnsadmin-docker/blob/develop/nginx/pdnsadmin.conf)
Currently, we only support nginx http loading as default, and going to add https feature for this docker container in near future.
In the scenario which we are planing is, We will setup a Nginx on the main server and it acts as the reverproxy for pdnsadmin container. It could provide more flexibily for us to deploy, clone, manage docker container.

## Logging and Errors

### Logging
All logs should now print out in stdout/stderr and are available via the docker logs command:
```
docker logs <CONTAINER_NAME>
```
### WebRoot
the current WEBROOT we place it at ```/pdnsadmin``` inside the container to easy to maintenance and troubleshoot.
