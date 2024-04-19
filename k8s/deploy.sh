#!/bin/zsh

KUBECTL="kubectl"
NAMESPACE="default"

$KUBECTL -n $NAMESPACE apply -f Deployment.yaml
$KUBECTL -n $NAMESPACE apply -f Services.yaml
$KUBECTL -n $NAMESPACE apply -f Ingress.yaml
