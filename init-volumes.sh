#!/bin/bash

VOLUMES_DIR='volumes'

mkdir -p ${VOLUMES_DIR}/kotori/{conf,log,conf/apps-enabled}
mkdir -p ${VOLUMES_DIR}/mosquitto/{data,conf,log}
mkdir -p ${VOLUMES_DIR}/grafana/{data,log}
mkdir -p ${VOLUMES_DIR}/influxdb/{data,conf,log}
mkdir -p ${VOLUMES_DIR}/mongodb/{data,log}
mkdir -p ${VOLUMES_DIR}/redis/{data}
mkdir -p ${VOLUMES_DIR}/nginx/{cert,conf.d}
