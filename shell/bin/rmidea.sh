#!/usr/bin/env bash
#
# Description:  Removes all IntelliJ IDEA files from a Git project.
# Author:       Rubens Gomes

# IntelliJ IDEA iml files
IML_EXTENSION='iml'

printf "changing to Git root folder.\n"

cd $(git rev-parse --show-toplevel) || {
  printf "failed to change to Git root folder.\n" >&2
  exit 1
}

printf "removing .idea folder.\n"

rm -frv .idea/ || {
  printf ".idea folder not removed.\n" >&2
}

printf "removing all files ending in .iml.\n"

find "." -type f -name "*.${IML_EXTENSION}" -delete || {
  printf ".iml files not removed.\n" >&2
}

printf "done.\n"
