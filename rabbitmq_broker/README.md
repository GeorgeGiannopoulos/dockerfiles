# RabbitMQ Broker Dockerfile

## How it Works

- An `rabbitmq` image is used

- Default plugins are disabled

## How to Configure

1. Change the `rammitmq.conf` file based on rabbitMQ documantation

2. Change the `definitions.json` to pre-configure the broker

## How to Use

Build Image

```shell
docker build -t rabbitmq:latest .
```

Run container
```shell
docker run -d \
    --name rabbitmq \
    --restart unless-stopped \
    -v broker-conf:/etc/rabbitmq/conf.d/ \
    -v broker-data:/var/lib/rabbitmq \
    -v broker-logs:/var/log/rabbitmq \
    -v ./broker/rabbitmq.conf:/etc/rabbitmq/conf.d/rabbitmq.conf \
    -v ./broker/definitions.json:/etc/rabbitmq/definitions.json
    -p 5672:5672 \
    -p 5671:5671 \
    -p 127.0.0.1:15672:15672 \
    rabbitmq:latest
```

**NOTES:**

- Login to the UI using username `guest` and password `guest`

- This dockerfile does not take into account data encryption. **MUST BE EXTENDED**

- Add to **.dockerignore** any directory/file that needs to be excluded from docker image to keep the image size as small as possible
