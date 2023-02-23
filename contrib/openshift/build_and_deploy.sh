#!/bin/bash

set -exv
REPOSITORY="quay.io/app-sre"
IMAGE="${REPOSITORY}/clair"
GIT_HASH=`git rev-parse --short=7 HEAD`

git archive HEAD|
docker build -t clair-service:latest -

skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:clair-service:latest" \
    "docker://${IMAGE}:latest"

skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:clair-service:latest" \
    "docker://${IMAGE}:${GIT_HASH}"
