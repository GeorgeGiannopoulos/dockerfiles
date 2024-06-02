#!/bin/ash

set -e

rewire_mqtt() {
    echo "Initializing config files..."
    mkdir -p ${MQTT_CONFIG_DIR}
    mkdir -p ${MQTT_DATA_DIR}
    cp ${MQTT_BUILD_DIR}/mosquitto.conf ${MQTT_CONFIG_DIR}/mosquitto.conf
    cp ${MQTT_BUILD_DIR}/passwordfile ${MQTT_DATA_DIR}/passwordfile
}

initialize_config() {
    echo "Give Permissions to config files..."
    # Project Home
    # chmod -R 755 ${MQTT_PROJECT_HOME}
    chown -R ${MQTT_USER}:${MQTT_USER} ${MQTT_PROJECT_HOME}
    # Config directory
    chmod 0664 ${MQTT_CONFIG_DIR}/mosquitto.conf
    chown ${MQTT_USER}:${MQTT_USER} ${MQTT_CONFIG_DIR}/mosquitto.conf
    # Data Directory
    chmod 0664 ${MQTT_DATA_DIR}/passwordfile
    chown ${MQTT_USER}:${MQTT_USER} ${MQTT_DATA_DIR}/passwordfile
    # Logs Directory
    touch ${MQTT_LOGS_DIR}/mosquitto.log
    chmod 0664 ${MQTT_LOGS_DIR}/mosquitto.log
    chown -R ${MQTT_USER}:${MQTT_USER} ${MQTT_LOGS_DIR}
}

authentication_mqtt() {
    echo "Initializing authentication..."
    if [[ ! -f ${MQTT_DATA_DIR}/passwordfile ]]; then
        echo "The password file is missing!"
        exit 1
    fi

    mosquitto_passwd -U ${MQTT_DATA_DIR}/passwordfile
}

rewire_mqtt
initialize_config
authentication_mqtt

if [[ -z ${1} ]]; then
    exec /usr/sbin/mosquitto -v -c "/mosquitto/config/mosquitto.conf"
else
    exec "$@"
fi
