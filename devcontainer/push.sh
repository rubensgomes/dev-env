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

# File: push.sh
#
# Description: This shell script builds a docker image containing an Ubuntu
# development environment. Then, it pushes this image to my personal  repository
# in DockerHub.
#
# NOTE: I had to change the repository from private to public in DockerHub due
# to the constrained on the number of private repositories allowed in docker.io. 
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

###############################################################################
## MAIN BDOY
set -x

printf "building docker image...\n"
docker -D buildx build --tag "${DOCKER_REPO}:${TAG}" . || {
  printf "failed to build docker image.\n" >&2
  exit 1
}

printf "creating a tag image to push to docker.io registry...\n"
docker -D image tag "${DOCKER_REPO}:${TAG}" "${FULL_IMAGE}" || {
  printf "failed to tag image\n"
  exit 1
}

printf "signing in to DockerHub...\n"
docker -D login --username "${DOCKER_USERNAME}" --password "${DOCKERIO_PAT}" || {
  printf "failed to login\n" >&2
  exit 1
}

printf "pushing image to DockerHub...\n"
docker -D image push "${FULL_IMAGE}" || {
  printf "failed to push image\n" >&2
  exit 1
}

printf "done\n"

