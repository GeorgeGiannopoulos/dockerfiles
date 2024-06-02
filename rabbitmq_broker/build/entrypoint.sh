#!/bin/bash

/build/certificates.sh
sleep 1
if [[ -z ${1} ]]; then
    exec /usr/local/bin/docker-entrypoint.sh rabbitmq-server
else
    exec /usr/local/bin/docker-entrypoint.sh "$@"
fi
