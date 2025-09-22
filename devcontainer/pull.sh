#!/usr/bin/env bash

# File: pull.sh
#
# Description: This shell script pull the devontainer image from my personal
# DockerHub repository.
#
# Author: Rubens Gomes

###############################################################################
## GLOBAL CONSTANTS
readonly IMAGE_NAME="devcontainer"
readonly DOCKER_USERNAME="rubensgomes"
readonly DOCKER_REPO="${DOCKER_USERNAME}/${IMAGE_NAME}"
readonly DOCKER_REGISTRY="docker.io"
readonly TAG="0.0.1"
readonly FULL_IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPO}:${TAG}"

################################################################################
## MAIN BDOY

printf "signing in to DockerHub...\n"
docker login --username "${DOCKER_USERNAME}" --password "${DOCKERIO_PAT}" || {
  printf "failed to login\n" >&2
  exit 1
}

printf "pulling image from repository...\n"
docker image pull "${DOCKER_REPO}:${TAG}" || {
  printf "failed to pull image\n" >&2
  exit 1
}

printf "done\n"
