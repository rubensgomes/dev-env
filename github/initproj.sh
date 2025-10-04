#!/usr/bin/env bash

# File: initproj.sh
#
# Description: This shell script sets up a public git repo in GitHub. This
#              Git repo is meant to be used for Gradle projects.
#
# Author: Rubens Gomes

###############################################################################
## GLOBAL CONSTANTS
readonly EMAIL="rubens.s.gomes@gmail.com"
readonly USERNAME="rubensgomes"

###############################################################################
## ARGUMENT CHECK
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

project_name="$1"

###############################################################################
## MAIN BODY
set -ex

printf "initializing local repo in main branch...\n"
git init -b main
git add .

printf "setting git config ...\n"
git config --local core.editor "vim"
git config --local user.name "Rubens Gomes"
git config --local user.email "${EMAIL}"

if [[ -z "$(git status --porcelain)" ]]; then
  printf "Nothing to commit.\n "
else
  printf "initial commit...\n"
  git commit -m "initial commit" -a
fi

printf "store credentials in local repo...\n"
git config credential.helper store

printf "logout %s from github...\n" "${USERNAME}"

if ! gh auth logout --user "${USERNAME}"; then
  printf "nothing to logout.\n"
fi

printf "login to github ...\n"
echo "${RUBENS_PAT_TOKEN}" | gh auth login --with-token

if gh repo view ${USERNAME}/${project_name} > /dev/null 2>&1; then
  printf "Repo %s already exists.\n" "${USERNAME}/${project_name}"
else
  printf "creating remote homepage...\n"
  # must be public repo to use GitHub Actions for free !!!
  gh repo create --homepage "https://github.com/rubensgomes" \
    --public "${project_name}"
  printf "pushing local changes to remote repo...\n"
  git remote add origin "https://github.com/rubensgomes/${project_name}"
  git push -u origin main
fi


printf "logout %s from github...\n" "${USERNAME}"

if ! gh auth logout --user "${USERNAME}"; then
  printf "nothing to logout.\n"
fi

cat<<EOF
Now you must go to https://github.com/rubensgomes/${project_name}.
Then, create a release branch by clicking on the \"main\" branch
drop-down to View all branches. Then, create the release branch
from main.
EOF

sleep 30

printf "done\n"
