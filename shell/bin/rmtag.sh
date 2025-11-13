#!/usr/bin/env bash

# File: initproj.sh
#
# Description: This shell script removes local/remote Git tags starting with
# the given character.
#
# Author: Rubens Gomes

# immediatelly exit if any command fails.
set -e

readonly START_CHARS='1'

# Delete local and remote git tags starting with "1"
for tag in $(git tag | grep "^${START_CHARS}"); do
  echo "Deleting tag: $tag"
  git tag -d "$tag"                          # delete locally
  git push origin ":refs/tags/$tag"          # delete remotely
done

printf "done.\n"
