#!/bin/bash

# certificates.sh ----------------------------------------------------------------------------------
#
# Script Description:
#    This script manages the SSL certificates of the RabbitMQ
#    The script executes the following steps:
#        1. Checks if certificates exist and if yes then exits
#        2. Generates a CA (Certificate Authority) for signed the Certificates
#        3. Generates the Server Certificates and signed them using the CA
#
# --------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------
# Initialize script
# --------------------------------------------------------------------------------------------------
#
set -e
source "/build/functions.sh"


# --------------------------------------------------------------------------------------------------
# Main
# --------------------------------------------------------------------------------------------------
#
log_info "Running: ${0##*/}"

if [[ "${EXECUTION_MODE}" != 'production' ]]; then
    exit 0
fi

mkdir -p "${SSL_CERTIFICATES_DIR}"
mkdir -p "${SSL_CERTIFICATES_DIR}/ca"
mkdir -p "${SSL_CERTIFICATES_DIR}/server"


# ------------------------------------------
# 1. Certificates already exist
# ------------------------------------------
#
if [[ -f "${CA_SSL_DIR}/${CA_SSL_CRT}" && -f "${SERVER_SSL_DIR}/${SERVER_SSL_CRT}" ]]; then
    log_info "CA and Server Certificates found! Exitting..."
    exit 0
fi


# ------------------------------------------
# 2. Generates a CA (Certificate Authority)
# ------------------------------------------
#
# Generate a Private Key for the CA
openssl genrsa -out "${CA_SSL_DIR}/${CA_SSL_KEY}" ${CA_RSA_KEY_SIZE}
# Generate a Self-Signed Certificate
openssl req -new                               \
            -x509                              \
            -key "${CA_SSL_DIR}/${CA_SSL_KEY}" \
            -out ${CA_SSL_DIR}/${CA_SSL_CRT}   \
            -outform DER                       \
            -nodes                             \
            -days ${DAYS}                      \
            -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/OU=${SECTOR}/CN=${DOMAIN_NAME}/emailAddress=${EMAIL}"


# ------------------------------------------
# 3. Generates the Server Certificate
# ------------------------------------------
#
# Generate a Private Key for the Server Certificate
openssl genrsa -out "${SERVER_SSL_DIR}/${SERVER_SSL_KEY}" ${SERVER_RSA_KEY_SIZE}
# Generate a Certificate Signing Request
openssl req -new                                       \
            -key "${SERVER_SSL_DIR}/${SERVER_SSL_KEY}" \
            -out "${SERVER_SSL_DIR}/${SERVER_SSL_CSR}" \
            -outform PEM                               \
            -nodes                                     \
            -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/CN=${DOMAIN_NAME}"\

# Generate a Server Certificate Signed by the CA
openssl x509 -req                                       \
             -in "${SERVER_SSL_DIR}/${SERVER_SSL_CSR}"  \
             -CA "${CA_SSL_DIR}/${CA_SSL_CRT}"          \
             -CAkey "${CA_SSL_DIR}/${CA_SSL_KEY}"       \
             -CAcreateserial                            \
             -out "${SERVER_SSL_DIR}/${SERVER_SSL_CRT}" \
             -notext                                    \
             -batch                                     \
             -days ${DAYS}                              \
             -sha256

chown rabbitmq:rabbitmq -R "${SSL_CERTIFICATES_DIR}"
