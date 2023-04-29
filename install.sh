#!/bin/bash

function reset_git () {
  rm -rf .git

  git init
  git add -A
  git commit -m 'Init'

  read -p "Git-Repository: " GITURL
  echo $GITURL
  git remote add origin $GITURL
  git push --set-upstream origin main
}

function set_namespace () {
  read -p "Namespace: (default) " NAMESPACE

  if [[ -z "$NAMESPACE" ]]
  then
    NAMESPACE="default"
  fi

  echo $NAMESPACE
  sed -i '/export NAMESPACE/s/=".*$/="'"$NAMESPACE"'"/' update.sh
}

function install_all () {
  (
    cd frontend
    npm install
  )
  (
    cd backend
    pip install -r requirements.txt
  )
}

install_all
set_namespace
reset_git
