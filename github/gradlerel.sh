#!/usr/bin/env bash

# File: gradlerel.sh
#
# Description: This shell script builds, commit/push, release, and publish
#              Rubens Gradle project to its GitHub Package.
#
# Limitations: IT MUST BE RUN FROM A STANDARD RUBENS' GRADLE PROJECT
#
# Author: Rubens Gomes

###############################################################################
## MAIN BODY
set -ex

printf "switching to project root directory...\n"
cd $(git rev-parse --show-toplevel)

printf "building project...\n"
./gradlew --info clean build

printf "committing and pushing local change...\n"
git commit -m "updates" -a
git push

printf "releasing software...\n"
./gradlew --info release

printf "publishing built package...\n"
git checkout release
git pull
./gradlew --info publish
git checkout main

printf "done\n"
