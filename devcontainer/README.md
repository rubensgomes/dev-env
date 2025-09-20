# devcontainer

This folder contains a Dockerfile and other relevant files used to set up a
development environment focused on python + java development using Claude Code.

## Steps to do in GitHub Actions

Go to your repo → Settings → Secrets and variables → Actions → New repository secret:

Secret name                    Value
DOCKERHUB_USERNAME             Your Docker Hub username
DOCKERHUB_TOKEN                Docker Hub password or token
ZSCALER_ROOT_CERT              The ZScaler root certificate
