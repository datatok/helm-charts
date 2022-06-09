#!/bin/bash

set -ex

helm delete zep-spark
helm delete spark-spec
helm delete zep-int
helm delete zep