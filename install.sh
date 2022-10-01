#!/bin/bash

(
    cd frontend
    yarn install
)
(
    cd backend
    pip install -r requirements.txt
)
git remote remove origin