# MQTT Broker Dockerfile

## How it Works

- An `eclipse-mosquitto` image is used

- An environmental variable named `MQTT_PROJECT_HOME` is used to keep the path of the project inside the image

- The custom configuration is copied inside the container

- The passwordfile that contains the user/password combinations is copied inside the container

- An `entrypoint.sh` script that installs the broker using the above config files is copied to the container

- The entrypoint script is executed

## How to Configure

1. Select a `eclipse-mosquitto` image version that matches the one used to develop the project (replace `latest`)

2. Change the configuration of the broker

3. Add user/password combinations for every user that will connect to the broker

## How to Use

Build Image

```shell
docker build -t broker:latest .
```

Run container
```shell
docker run -idt \
    --name broker \
    --restart unless-stopped \
    -v broker:/mosquitto \
    -v broker-config:/mosquitto/config \
    -v broker-data:/mosquitto/data \
    -v broker-log:/mosquitto/log \
    -p 1883:1883 \
    broker:latest
```

**NOTES:**

- Currently version `2.0.11` was tested

- Each MQTT client must be authenticated (included in passwordfile) to be connected

- This dockerfile does not take into account data encryption. **MUST BE EXTENDED**

- Add to **.dockerignore** any directory/file that needs to be excluded from docker image to keep the image size as small as possible
