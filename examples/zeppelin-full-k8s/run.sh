#!/bin/bash

CHART_DIR=./charts
THIS_DIR=./examples/zeppelin-full-k8s

set -ex

helm upgrade --install \
    zep-spark \
    ${CHART_DIR}/spark-artifacts

helm upgrade --install \
    --values ${CHART_DIR}/spark-spec/values.yaml \
    --values ${THIS_DIR}/spark-spec.yaml \
    spark-spec \
    ${CHART_DIR}/spark-spec

helm upgrade --install \
    --values ${CHART_DIR}/spark-spec/values.yaml \
    --values ${THIS_DIR}/zeppelin-interpreter-spec.yaml \
    zep-int \
    ${CHART_DIR}/zeppelin-interpreter-spec

helm upgrade --install \
    --values ${CHART_DIR}/zeppelin/values.yaml \
    --values ${THIS_DIR}/zeppelin.yaml \
    zep \
    ${CHART_DIR}/zeppelin