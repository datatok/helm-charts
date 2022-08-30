#!/bin/bash

CHART_DIR=./charts
THIS_DIR=./examples/zeppelin-full-k8s

set -ex

helm upgrade --install \
    --values ${CHART_DIR}/zeppelin/values.yaml \
    --values ${THIS_DIR}/zeppelin.yaml \
    zep \
    ${CHART_DIR}/zeppelin