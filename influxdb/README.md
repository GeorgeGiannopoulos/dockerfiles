# InfluxDB Dockerfile

## How it Works

- A `influxdb` image is used

- InfluxDB environmental variables are used to set default root user

- The port 8086 is exposed

- To ensure persistence of the database volumes are mounted

## How to Configure

1. Select a `influxdb` image version that matches the one used to develop the project

2. Change the default `username`, `password`, `org` and `bucket`. (This consider a **security leak**. There are other approaches)

## How to Use

Build Image:

```shell
docker build -t influxdb:latest .
```

Run container:

```shell
docker run -idt \
    --name influxdb \
    -v influxdb-data:/var/lib/influxdb2 \
    -v influxdb-conf:/etc/influxdb2 \
    -p 8086:8086 \
    influxdb:latest
```

**NOTES:**

- Use the correct influxdb version on build stage

- Volumes are used to ensure persistence of data. Mount them to specific paths to ensure they stay the same during container re-creation
