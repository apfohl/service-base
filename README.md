# Service base image

[Docker Hub](https://hub.docker.com/r/apfohl/service-base)

This is a base image for creating services with Docker containing multiple
applications. This is made possible by utilizing the
[Supervisor](http://supervisord.org) process control system.

## Usage

This image can be used as a base image for creating other images containing the
service applications. Use the `FROM` statement for your **Dockerfile** to
inherit from the **service-base** image:

```Dockerfile
FROM apfohl/service-base:latest
```

## Data persistence

In order to persist dynamic data generated inside container created by this
image, a Docker volume or a directory can be mounted inside the container. Every
dynamic data should reside in a predefined directory provided by the
**service-base** image. The data directory is `/data`. The **service-base**
image also provides a directory inside the data directory suitable for storing
log-files: `/data/logs`.

## Timezone

Setting a correct timezone is generally a good idea to have a time consistent
system. It's for example very useful for log-file creation with correct date and
time.

The timezone is managed internally by the **service-base** image and defaults to
`UTC`. You can override the timezone by passing the environment variable `TZ` to
the `docker run` command line:

```shell
docker run -e TZ="Europe/Berlin" [...]
```

## Supervisor

The **Supervisor** process control system is preconfigured and reads service
desciption files from the directory `/etc/etc/supervisord.d/*.conf`. In order to
register a new service with the supervisor, place the service description file
inside this directory. An example looks this this:

```
[program:nginx]
command=/usr/sbin/nginx -c /etc/nginx/nginx.conf
```

## Boot sequence

The **service-base** image also provides a boot sequence system that is
triggered everytime a container is started. It also functions a the entrypoint
of the whole service stack implemented with the **service-base** image.

If you need to do some preparational tasks before the supervisor takes over this
is the place you can use.

The **service-base** image provides a directory where you can put POSIX shell
scripts that get executed in alphabetical order. The directory is `/boot.d`.
Every script marked as executable will be executed.
