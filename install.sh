#!/bin/bash

function reset_git () {
    while [[ -z "$GITURL" ]]
    do
        read -p "Git-Repository [\$URL|github|gitlab]: " GITURL

        case "$(echo $GITURL | tr '[A-Z]' '[a-z]')" in
            "")
                echo "GITURL should not be empty" >&2
                ;;
            gitlab)
                GITURL=$(create_gitlab)
                echo "Created $GITURL"
                ;;
            github)
                GITURL=$(create_github)
                echo "Created $GITURL"
                ;;
            *)
                echo "Using $GITURL as remote URI"
                ;;
        esac
    done

    rm -rf .git

    git init
    git add -A
    git commit -m 'Init'
    git remote add origin $GITURL
    git push --set-upstream origin main
}

function create_gitlab () {
    if [[ -z "$GITLAB_URI" ]]
    then
        read -p "URI: " GITLAB_URI
    fi
    read -p "Name: " GITLAB_NAME
    if [[ -z "$GITLAB_TOKEN" ]]
    then
        read -p "Token: " GITLAB_TOKEN
    fi

    echo "Creating GitLab repository" >&2
    http https://$GITLAB_URI/api/v4/projects/ "PRIVATE-TOKEN:$GITLAB_TOKEN" "name=$GITLAB_NAME" |\
        jq -r .ssh_url_to_repo
}

function create_github () {
    read -p "Name: " GITHUB_NAME
    if [[ -z "$GITHUB_TOKEN" ]]
    then
        read -p "Token: " GITHUB_TOKEN
    fi

    echo "Creating GitHub repository" >&2
    https https://api.github.com/user/repos "Accept:application/vnd.github+json" "X-GitHub-Api-Version:2022-11-28" "Authorization:Bearer $GITHUB_TOKEN" "name=$GITHUB_NAME" |\
        jq -r .git_url
}

(
    cd frontend
    npm install
)
(
    cd backend
    pip install -r requirements.txt
)
reset_git
rm $0
