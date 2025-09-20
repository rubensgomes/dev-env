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
