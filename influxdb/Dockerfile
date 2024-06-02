FROM influxdb:2.7

ENV DOCKER_INFLUXDB_INIT_MODE=setup \
    INFLUXDB_REPORTING_DISABLED=false \
    DOCKER_INFLUXDB_INIT_USERNAME=defaultusername \
    DOCKER_INFLUXDB_INIT_PASSWORD=astrongpassword \
    DOCKER_INFLUXDB_INIT_ORG=defaltorg  \
    DOCKER_INFLUXDB_INIT_BUCKET=defaultbucker \
    DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=default.user.token

COPY init/* /docker-entrypoint-initdb.d/

# Expose to the World:
EXPOSE 8086

# Ensure Persistence of Data:
VOLUME ["/var/lib/influxdb2", "/etc/influxdb2"]
