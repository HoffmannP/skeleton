#!/bin/bash

set -e

export SERVER_NAME=$(git remote get-url origin | cut -d@ -f2 | sed -r 's/:/:5050\//;s/.git//')
export NAME=$(echo $SERVER_NAME | rev | cut -d\/ -f1 | rev)
export NAMESPACE="default"
KUBECTL="rancher kubectl --insecure-skip-tls-verify"

if [[ "$1" != "--nobuild" ]]
then
    (
        cd frontend
        npm run build
    )
    docker build -t "${SERVER_NAME}:latest" .
else
    shift
fi

VERSION="$(date '+%Y-%V-%a')"
docker tag "$SERVER_NAME:latest" "$SERVER_NAME:$VERSION"
docker push "$SERVER_NAME:latest"
docker push "$SERVER_NAME:$VERSION"

if [[ -f "deploy.yaml" ]]
then
    $KUBECTL -n $NAMESPACE rollout restart deploy $NAME
    echo "Hallo"
else
    cat deploy.yaml.template | envsubst > deploy.yaml
    rm deploy.yaml.template
    $KUBECTL -n $NAMESPACE apply -f deploy.yaml
fi
