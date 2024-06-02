FROM eclipse-mosquitto:2.0.11

ENV MQTT_USER=1883 \
    MQTT_PROJECT_HOME=/mosquitto \
    MQTT_BUILD_DIR=/build \
    MQTT_CONFIG_DIR=/mosquitto/config \
    MQTT_DATA_DIR=/mosquitto/data \
    MQTT_LOGS_DIR=/mosquitto/log

# Configuration:
ADD ./build/mosquitto.conf ${MQTT_BUILD_DIR}/mosquitto.conf
# Broker Authentication:
ADD ./build/passwordfile ${MQTT_BUILD_DIR}/passwordfile

COPY ./build/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# Expose to the World:
EXPOSE 1883

# Ensure Persistence of Data:
VOLUME ["/mosquitto"]

# Run the application:
ENTRYPOINT ["/sbin/entrypoint.sh"]
