# XMPP Server Dockerfile

Use [XMPP Client](https://github.com/GeorgeGiannopoulos/clients/tree/master/xmpp_client) to connect to it

## How it Works

- An `ubuntu` image is used

- Environmental variables are use for openfire installation

- A script that installs all the dependencies is run

- Java is installed

- Openfile XMPP server is installed (from source)

- Openfire custom configuration is copied to the container

- An `entrypoint.sh` script is executed

## How to Configure

1. Change the `openfire` version that matches the one used to develop the project

2. Change the configuration of the openfire server

## How to Use

Build Image

```shell
docker build -t xmpp:latest .
```

Run container
```shell
docker run -d \
    --name xmpp \
    --restart unless-stopped \
    -v xmpp-lib:/var/lib/openfire \
    -v xmpp-log:/var/log/openfire \
    -p 9090:9090 \
    -p 5222:5222 \
    xmpp:latest
```

**NOTES:**

- Login to the UI using username `admin` and password `adm1n!`

- `ubuntu:20.04` is used as a base image

- This dockerfile does not take into account data encryption. **MUST BE EXTENDED**

- Add to **.dockerignore** any directory/file that needs to be excluded from docker image to keep the image size as small as possible
