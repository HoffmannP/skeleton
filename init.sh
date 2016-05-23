#!/bin/bash

if [[ ! -d ".git" ]]; then
	git clone https://github.com/HoffmannP/skeleton.git .
fi
rm -rf .git

PROJECT="$(basename "$(pwd)")"
rm $0 TODO.md README.md
rename 's/{PROJECT}/'"$PROJECT"'/' *

git init
echo "ready to code"
subl $PROJECT.sublime-project
