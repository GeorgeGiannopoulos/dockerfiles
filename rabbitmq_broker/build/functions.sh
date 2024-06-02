#!/bin/bash

# functions.sh -------------------------------------------------------------------------------------
#
# Script Description:
#    This script contains functions used by all the scripts
#
# --------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------
# Environmental
# --------------------------------------------------------------------------------------------------
EXECUTION_MODE="${EXECUTION_MODE:-production}"  # Options: 'production', 'deployment'
COUNTRY="${COUNTRY:-GR}"
STATE="${STATE:-Thessaloniki}"
LOCATION="${LOCATION:-Thessaloniki}"
ORGANIZATION="${ORGANIZATION:-ORG1}"
SECTOR="${SECTOR:-SECT1}"
DOMAIN_NAME="${DOMAIN_NAME:-domain.gr}"


# --------------------------------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------------------------------
# Logging
VERBOSE=false
# Certificates Arguments
EMAIL='email@domain.gr' # NOTE: Adding a valid address is strongly recommended
CA_RSA_KEY_SIZE=4096
SERVER_RSA_KEY_SIZE=2048
DAYS=3650
# Paths
RABBITMQ_DIR='/etc/rabbitmq'
SSL_CERTIFICATES_DIR="${RABBITMQ_DIR}/ssl"
CA_SSL_DIR="${SSL_CERTIFICATES_DIR}/ca"
SERVER_SSL_DIR="${SSL_CERTIFICATES_DIR}/server"
CA_SSL_KEY='ca.key'
CA_SSL_CRT='cacert.pem'
SERVER_SSL_KEY='key.pem'
SERVER_SSL_CSR='req.pem'
SERVER_SSL_CRT='cert.pem'


# --------------------------------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------------------------------
log() {
    printf '%s %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%S:%3NZ") $1 | $2"
    return
}

log_info() {
    log "INFO " "$1"
    return
}

log_warn() {
    log "WARNING" "$1"
    return
}

log_error() {
    log "ERROR" "$1"
    return
}
