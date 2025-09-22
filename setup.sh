#!/usr/bin/env bash

# File: setup.sh
#
# Description: This shell script sets up a git repo in GitHub. 
#
# Author: Rubens Gomes

###############################################################################
## GLOBAL CONSTANTS
readonly PROJ_NAME="dev-env"

###############################################################################
## MAIN BDOY
set -ex

printf "initializing local repo in main branch...\n"
git init -b main
git add .

printf "initial commit...\n"
git commit -m "initial commit" -a

printf "store credentials in local repo...\n"
git config credential.helper store

printf "creating remote homepage...\n"
# must be public repo to use GitHub Actions for free !!!
gh repo create --homepage "https://github.com/rubensgomes" \
  --public "${PROJ_NAME}"

printf "pushing local changes to remote repo...\n"
git remote add origin "https://github.com/rubensgomes/${PROJ_NAME}"
git push -u origin main

printf "done\n"
