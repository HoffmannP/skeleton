#!/bin/bash

set -e

SERVER="macberengar.rz.uni-jena.de:5000"
NAME="##############"
SERVER_NAME=$SERVER/$NAME

(
    cd frontend
    rm public/build/assets/*
    yarn build
)

docker build -t "${SERVER_NAME}:latest" .
docker tag "${SERVER_NAME}:latest" "${SERVER_NAME}:$(date '+%Y-%V-%a')"
docker push "$SERVER_NAME"

http --auth "token-zwksm:$(cat secret.key)" \
    POST "https://rancher.rz.uni-jena.de/v3/project/c-kl5lw:p-h5jvn/workloads/deployment:default:"$NAME"?action=redeploy"
