#!/bin/bash

set -e

SERVER="macberengar.rz.uni-jena.de:5000"
NAME="##############"
SERVER_NAME=$SERVER/$NAME

if [[ "$1" != "--nobuild" ]]
then
    (
        cd frontend
        rm public/build/assets/*
        yarn build
    )
    docker build -t "${SERVER_NAME}:latest" .
else
    shift
fi

VERSION="$(date '+%Y-%V-%a')"
docker tag "$SERVER_NAME:latest" "$SERVER_NAME:$VERSION"
docker push "$SERVER_NAME:latest"
docker push "$SERVER_NAME:$VERSION"

if [[ "$1" == "--deploy" ]]
then
    http --auth "token-zwksm:$(cat secret.key)" \
        POST "https://rancher.rz.uni-jena.de/v3/projects/c-t8sln:p-k7zzr/workload" <<EOJ
{"type":"workload",
"namespaceId":"default",
"containers":[{
    "type":"container",
    "image":"$SERVER_NAME:$VERSION",
    "name":"$NAME"
"name":"$NAME"}
EOJ
else
    http --auth "token-zwksm:$(cat secret.key)" \
        POST "https://rancher.rz.uni-jena.de/v3/project/c-kl5lw:p-h5jvn/workloads/deployment:default:"$NAME"?action=redeploy"
fi