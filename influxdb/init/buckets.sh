#!/bin/sh

set -e

# Create Buckets
influx bucket create --org defaltorg --name Bucket1
influx bucket create --org defaltorg --name Bucket2 --retention 30d
