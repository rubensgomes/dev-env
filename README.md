# dev-env

This folder contains configuration files used to set up a development
environment on UNIX.

## Git related commands

```shell
# store credentials in local repo
git config credential.helper store
# set up a public repo
PROJ_NAME=dev-env
git init -b main
git add .
git commit -m "initial commit" -a
gh repo create --homepage "https://github.com/rubensgomes" --public "${PROJ_NAME}"
git remote add origin "https://github.com/rubensgomes/${PROJ_NAME}"
git push -u origin main
```

## Steps to do in GitHub Actions

The following secrets are needed in the GitHub Actions Workflow:

- Go to your repo → Settings → Secrets and variables → Actions → New repository secret:

Secret name                    Value

- DOCKERHUB_USERNAME             Your Docker Hub username
- DOCKERHUB_TOKEN                Docker Hub password or token
- ZSCALER_ROOT_CERT              The ZScaler root certificate

## Steps to set up a PAT (personal access token)

The PAT_TOKEN is needed in the GitHub Actions Workflow:

- Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token
- Give repo permissions (or at least: repo, workflow)
- Add the token as a secret in your repo, e.g., PAT_TOKEN
