# Copyright 2025 Rubens Gomes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the__LICENSE] [1].

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
