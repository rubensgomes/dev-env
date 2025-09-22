#!/usr/bin/env bash
# Rubens personal shell environment profile
#

###############################################################################
# are we on macOS?

if [[ "$(uname)" == "Darwin" ]]; then
  echo "Running on macOS"

  # homebrew prefix is needed for a few paths
  export PREFIX="$(brew --prefix)" || {
    printf "Failed to find brew prefix.\n" >&2
    sleep 5
    exit 1
  }

  ## GNU vs MacOS sed?
  # export GNU_SED=FALSE # use macOS sed
  export GNU_SED=TRUE # use GNU sed

  if [[ "${GNU_SED:-}" == TRUE ]]; then
    GNU_PATH="${PREFIX}/opt/gnu-sed/libexec/gnubin"
    GNU_MANPATH="${PREFIX}/opt/gnu-sed/libexec/man"
    # Add GNU sed
    PATH="${GNU_PATH:-}:${PATH}"
    MANPATH="${GNU_MANPATH:-}:${MANPATH}"
  fi

  # We must use 3.13 for the newer python project
  PATH="${PREFIX}/opt/python@3.13/bin:${PATH}"
  # We must use GNU util-linux tools (e.g., getopt)
  PATH="${PREFIX}/opt/util-linux/bin:${PATH}"
  PATH="${PREFIX}/opt/util-linux/sbin:${PATH}"

  ###############################################################################
  ## Homebrew installed utilities

  # For compilers and linkers to find the right libraries for 
  # util-linux, linpq, node@20:
  export CPPFLAGS="\
-I${PREFIX}/opt/util-linux/include \
-I${PREFIX}/opt/libpq/include \
-I${PREFIX}/opt/node@20/include"
  export LDFLAGS="\
-L${PREFIX}/opt/util-linux/lib \
-L${PREFIX}/opt/libpq/lib \
-L${PREFIX}/opt/node@20/lib "

  ###############################################################################
  ## Java Environment Properties
  JAVA_VERSION=21
  #JAVA_VERSION=23
  #JAVA_VERSION=24

  case "${JAVA_VERSION}" in
  21) # Amazon JAVA 21
    export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
    ;;
  23) # OpenJDK JAVA 23
    export JAVA_HOME="$(/usr/libexec/java_home -v 23)"
    ;;
  24) # OpenJDK JAVA 24
    export JAVA_HOME="$(/usr/libexec/java_home -v 24)"
    ;;
  *)
    echo "JAVA_VERSION [${JAVA_VERSION}] not supported." 1>&2
    ;;
  esac

  # Add JAVA_HOME
  export PATH="${JAVA_HOME}/bin:${PATH}"
  export MANPATH="${JAVA_HOME}/man:${MANPATH}"

  # Ansible fix for:
  # ERROR! A worker was found in a dead state
  # https://www.whatan00b.com/posts/debugging-a-segfault-from-ansible/
  export no_proxy='*'
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

  ## nvm
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Secret credentials to be used during docker image builds
  export MARIADB_ROOT_PWD="root"

  ###############################################################################
  ## Personal Aliases
  alias cp="cp -i"
  alias rm="rm -i"
  alias mv="mv -i"

###############################################################################
else
  export PREFIX=""
  # currently (09/11/2025) only java 21 is installed on my Ubuntu linux
  export JAVA_HOME="/usr/bin/java"
fi


###############################################################################
# PATH 

# give preference to binaries in my local bin folders first.
#  ${HOME}/.local/bin needed to resolve 'poetry' 
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/bin/tools:${PATH}"

PATH="${PATH}:/usr/local/bin"
PATH="${PATH}:/bin"
PATH="${PATH}:/usr/bin"
PATH="${PATH}:/sbin"
PATH="${PATH}:/usr/sbin"

export PATH

###############################################################################
# PROMPT PS1

PROMPT="$ " && declare -x PROMPT
PS1="$ " && declare -x PS1

###############################################################################
# HISTORY
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=100000
export HISTFILESIZE=${HISTSIZE}
# Turn on parallel history Append (rather than overwrite) history.
shopt -s histappend
history -a

###############################################################################
# Constants
[[ -z "${TRUE:-}" ]] && export readonly  TRUE=0
[[ -z "${FALSE:-}" ]] && export readonly  FALSE=1


###############################################################################
## GitHub CLI
## https://github.com/rubensgomes --> Profile --> Settings 
##   --> Developer settings --> Personal access tokens --> Tokens (classic)
## Token name: Onbe laptop 
## Permissions: repo only.
## Token name: Work laptop 
## Permissions: repo + workflow
## token generated September 19, 2025
## Token expiry: never 
export GH_TOKEN="<TODO>"

###############################################################################
## Miscellaneous GIT Environment Properties
#export GIT_SSH_COMMAND="ssh -vvv"

###############################################################################
# Rubens Personal CircleCI account
# may be needed during CircleCI Git operations with BitBucket
declare -x CIRCLECI_GIT_USER_EMAIL="rubens.bitbucket@mail.com"
declare -x CIRCLECI_GIT_USER_NAME="Rubens Gomes"
declare -x CIRCLECI_CLI_TOKEN='<TODO>'

###############################################################################
# New Relic API Key
#export TF_VAR_NRApiKey="<TODO>"
#export TF_VAR_NRApiKey="<TODO>"
export TF_VAR_NRApiKey="<TODO>"

## TeamCity Access Token to use in REST APIs:
declare -x TEAMCITY_ACCESS_TOKEN="<TODO>"

# gradle
GRADLE_USER_HOME="${HOME}/.gradle"
export GRADLE_USER_HOME

# completions for poetry python
export BASH_COMPLETION="~/.bash_completion"
[[ -f "${BASH_COMPLETION}" ]] && source "${BASH_COMPLETION}" 

# Use bash-completion, if available
# macOS
[[ $PS1 && -f ${PREFIX}/opt/bash-completion/bash_completion ]] && \
    . ${PREFIX}/opt/bash-completion/bash_completion

# linux
[[  -f /etc/bash_completion ]] && {
  source /etc/bash_completion
}

# Rubens Gomes CircleCI account
declare -x CIRCLECI_GIT_USER_EMAIL="rubens.s.gomes@gmail.com"
declare -x CIRCLECI_GIT_USER_NAME="Rubens Gomes"
declare -x CIRCLECI_CLI_TOKEN='<TODO>'

###############################################################################
# Rubens Gomes SonarQube account token
export SONAR_TOKEN="<TODO>"

###############################################################################
# Rubens Gomes repsy.io account
export REPSY_USERNAME="rubensgomes"
export REPSY_PASSWORD="<TODO>"

###############################################################################
# Rubens Gomes repsy.io account
# Credentials to push images to Rubens Personal Docker Hub repository:
# https://hub.docker.com/repositories/rubensgomes
export DOCKERIO_USERNAME="rubensgomes"
export DOCKERIO_PASSWORD="<TODO>"
# Docker PAT (personal access token) generated 06/09/2025 @ 9:50 pm CDT
export DOCKERIO_PAT="<TODO>"

# util-linux compilers paths
# export LDFLAGS="-L/usr/local/opt/util-linux/lib"
# export CPPFLAGS="-I/usr/local/opt/util-linux/include"

source  ~/.bashrc

