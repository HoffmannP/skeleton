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
reset_git
