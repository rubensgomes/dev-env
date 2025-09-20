# devcontainer

This folder contains a Dockerfile used to set up a personal
containerized development environment focused on python + java development
using Claude Code.

## GitHub Actions Workflow

I have set up a GitHub Actions Workflow to build the containerized image and
push it to a personal docker.io registry repository.

### GitHub Setting PAT_TOKEN (personal access token)

A PAT_TOKEN is needed in the GitHub Actions Workflow:

- Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token
- Give repo permissions (or at least: repo, workflow)
- Add the token as a secret in your repo, e.g., PAT_TOKEN

### GitHub Repo Actions Secrets

The following secrets are needed in the GitHub Actions Workflow:

- Go to your repo → Settings → Secrets and variables → 
Actions → New repository secret:

Secret name                    Value

- DOCKERHUB_USERNAME             Your Docker Hub username
- DOCKERHUB_TOKEN                Docker Hub password or token
- ZSCALER_ROOT_CERT              The ZScaler root certificate
- PAT_TOKEN                      The user's PAT token w/repo+workflow

### GitHub Repo Action Settings

- Go to your repository → Settings → Actions → General → Workflow permissions
- Make sure “Read and write permissions” is selected for the GITHUB_TOKEN
- Optional: check “Allow GitHub Actions to create and approve pull requests” if needed.
