#!/bin/bash

CHART_DIR=./charts
THIS_DIR=./examples/zeppelin-full-k8s

set -ex

kubectl apply -f ${THIS_DIR}/zep-spark-conf-cm.yaml

helm upgrade --install \
    zep-spark \
    ${CHART_DIR}/spark-artifacts

helm upgrade --install \
    --values ${CHART_DIR}/spark-spec/values.yaml \
    --values ${THIS_DIR}/spark-spec.yaml \
    spark-spec \
    ${CHART_DIR}/spark-spec

./run_zep_int_spec.sh

./run_zep.sh