#!/bin/bash

(
    cd frontend
    npm install
)
(
    cd backend
    pip install -r requirements.txt
)
git remote remove origin
read -p "Namespace: (default)" NAMESPACE

if [[ -n "$NAMESPACE" ]]
then
    NAMESPACE=default
else
    sed -i 's/NAMESPACE=default/NAMESPACE='"$NAMESPACE"'/' update.sh
fi