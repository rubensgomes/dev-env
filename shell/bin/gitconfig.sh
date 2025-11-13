#!/usr/bin/env bash
#
# Description: This shell script applies git config settings on a
# project and shell.
#
# Author: Rubens Gomes

# Note: Script must be sourced, not executed
# We avoid 'set -e' to prevent affecting the parent shell


# Check if script is being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  printf "Error: This script must be sourced, not executed.\n" >&2
  printf "Usage: source %s <user>\n" "$(basename "${BASH_SOURCE[0]}")" >&2
  exit 1
fi

VALID_USERS=("rubens-other" "rubensgomes" "rubens-copilot")

usage() {
  printf "Usage: source %s <user>\n" "$(basename "${BASH_SOURCE[0]}")"
  printf "  user: Must be one of: rubens-other, rubensgomes, rubens-copilot\n"
  printf "  Note: This script must be sourced, not executed\n"
  return 1
}

validate_user() {
  local user="$1"

  for valid_user in "${VALID_USERS[@]}"; do
    if [[ "${user}" == "${valid_user}" ]]; then
      return 0
    fi
  done

  printf "Error: Invalid user '%s'\n" "${user}" >&2
  printf "Valid users are: %s\n" "${VALID_USERS[*]}" >&2
  return 1
}

validate_environment_variables() {
  local missing_vars=()

  if [[ -z "${OTHER_GITHUB_EMAIL:-}" ]]; then
    missing_vars+=("OTHER_GITHUB_EMAIL")
  fi

  if [[ -z "${RUBENS_GITHUB_EMAIL:-}" ]]; then
    missing_vars+=("RUBENS_GITHUB_EMAIL")
  fi

  if [[ -z "${OTHER_GITHUB_USER:-}" ]]; then
    missing_vars+=("OTHER_GITHUB_USER")
  fi

  if [[ -z "${RUBENS_GITHUB_USER:-}" ]]; then
    missing_vars+=("RUBENS_GITHUB_USER")
  fi

  if [[ -z "${OTHER_PAT_TOKEN:-}" ]]; then
    missing_vars+=("OTHER_PAT_TOKEN")
  fi

  if [[ -z "${COPILOT_CLI_PAT_TOKEN:-}" ]]; then
    missing_vars+=("COPILOT_CLI_PAT_TOKEN")
  fi

  if [[ -z "${RUBENS_PAT_TOKEN:-}" ]]; then
    missing_vars+=("RUBENS_PAT_TOKEN")
  fi

  if [[ ${#missing_vars[@]} -gt 0 ]]; then
    printf "Error: The following required environment variables are not defined:\n" >&2
    for var in "${missing_vars[@]}"; do
      printf "  - %s\n" "${var}" >&2
    done
    printf "\nPlease define these variables before running this script.\n" >&2
    return 1
  fi
}

configure_git_credentials() {
  printf "configuring git credential.helper\n"
  git config credential.helper store || return 1
}

configure_git_editor() {
  local editor="vim"
  printf "configuring git core.editor=%s\n" "${editor}"
  git config --local core.editor "${editor}" || return 1
}

configure_user_settings() {
  local user="$1"
  local user_name="Rubens Gomes"
  printf "configuring git user.name=%s\n" "${user_name}"
  git config --local user.name "${user_name}" || return 1

  if [[ "${user}" == "rubens-other" || "${user}" == "rubens-copilot" ]]; then
    printf "configuring git user.email=%s\n" "${OTHER_GITHUB_EMAIL}"
    git config --local user.email "${OTHER_GITHUB_EMAIL}" || return 1
  elif [[ "${user}" == "rubensgomes" ]]; then
    printf "configuring git user.email=%s\n" "${RUBENS_GITHUB_EMAIL}"
    git config --local user.email "${RUBENS_GITHUB_EMAIL}" || return 1
  fi
}

export_environment_variables() {
  local user="$1"

  printf "configuring GIT_COMMITTER_EMAIL, GITHUB_USER, GITHUB_TOKEN.\n"
  if [[ "${user}" == "rubens-other" || "${user}" == "rubens-copilot" ]]; then
    export GIT_COMMITTER_EMAIL="${OTHER_GITHUB_EMAIL}"
    export GITHUB_USER="${OTHER_GITHUB_USER}"

    if [[ "${user}" == "rubens-other" ]]; then
      printf "configuring rubens-other GITHUB_TOKEN, and GH_TOKEN\n"
      export GITHUB_TOKEN="${OTHER_PAT_TOKEN}"
      export GH_TOKEN="${OTHER_PAT_TOKEN}"
    elif [[ "${user}" == "rubens-copilot" ]]; then
      printf "configuring rubens-copilot GITHUB_TOKEN, and GH_TOKEN\n"
      export GITHUB_TOKEN="${COPILOT_CLI_PAT_TOKEN}"
      export GH_TOKEN="${COPILOT_CLI_PAT_TOKEN}"
    fi

  elif [[ "${user}" == "rubensgomes" ]]; then
    export GIT_COMMITTER_EMAIL="${RUBENS_GITHUB_EMAIL}"
    export GITHUB_USER="${RUBENS_GITHUB_USER}"
    printf "configuring rubensgomes GITHUB_TOKEN, and GH_TOKEN\n"
    export GITHUB_TOKEN="${RUBENS_PAT_TOKEN}"
    export GH_TOKEN="${RUBENS_PAT_TOKEN}"
  fi

  export GH_DEBUG="true"
  export GIT_AUTHOR_NAME="Rubens Gomes"
  export GIT_AUTHOR_EMAIL="${GIT_COMMITTER_EMAIL}"
  export GIT_EDITOR="vim"
}

display_configuration() {
  printf "USER=%s\n" "${USER}"
  printf "GH_DEBUG=%s\n" "${GH_DEBUG}"
  printf "GIT_AUTHOR_NAME=%s\n" "${GIT_AUTHOR_NAME}"
  printf "GIT_AUTHOR_EMAIL=%s\n" "${GIT_AUTHOR_EMAIL}"
  printf "GIT_COMMITTER_EMAIL=%s\n" "${GIT_COMMITTER_EMAIL}"
  printf "GIT_EDITOR=%s\n" "${GIT_EDITOR}"
  printf "GITHUB_USER=%s\n" "${GITHUB_USER}"
  printf "GITHUB_TOKEN=%s\n" "${GITHUB_TOKEN}"
  printf "GH_TOKEN=%s\n" "${GH_TOKEN}"
  printf "done.\n"
}

main() {
  if [[ $# -ne 1 ]]; then
    usage
    return 1
  fi

  USER="$1"
  validate_user "${USER}" || return 1
  validate_environment_variables || return 1

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    configure_git_credentials || return 1
    configure_git_editor || return 1
    configure_user_settings "${USER}" || return 1
  fi

  export_environment_variables "${USER}" || return 1
  display_configuration
}

main "$@"
