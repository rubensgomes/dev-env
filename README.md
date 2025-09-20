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



