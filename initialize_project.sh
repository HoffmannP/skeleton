#!/bin/bash

read -p "Name: " PROJECT_NAME

if [[ -d "$PROJECT_NAME" ]]
then
    echo "Folder $PROJECT_NAME already exists" >2
    exit 1
fi

mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

npx sv create frontend --template minimal --no-types --no-add-ons --install npm
cp frontend.dev.sh frontend/dev.sh
(
    cd frontend
    npm install --save-dev standard @sveltejs/adapter-static standard prettier-standard
    npm audit fix --force
    sed -i '1s/adapter-auto/adapter-static/' svelte.config.js
    echo "export const prerender = true;" >> src/routes/+layout.js
    echo -e "node_modules\n/build/.svelte-kit" >> .gitignore
)

(
    cd backend
    python -m venv .venv
    source .venv/bin/activate
    python -m pip install -r requirements.txts
)

helm create $PROJECT_NAME
mv $PROJECT_NAME helm
cat <<EOT
# add to values.yaml at .ingress.annotations:
nginx.ingress.kubernetes.io/proxy-body-size: "0"
nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
EOT
