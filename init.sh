#!/bin/bash

if [[ ! -d ".git" ]]; then
	git clone https://github.com/HoffmannP/skeleton.git .
fi

rm -rf .git
git init
echo "ready to code"
