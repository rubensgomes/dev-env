#!/usr/bin/env bash
# Rubens personal shell environment profile
#

# only java 21 is installed on my Ubuntu linux
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

###############################################################################
# PATH 

PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/bin/tools:${PATH}"

PATH="${PATH}:/usr/local/bin"
PATH="${PATH}:/bin"
PATH="${PATH}:/usr/bin"
PATH="${PATH}:/sbin"
PATH="${PATH}:/usr/sbin"

PATH="${PATH}:/opt/gradle/bin"
export PATH

###############################################################################
# HISTORY
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=100000
export HISTFILESIZE=${HISTSIZE}
# Turn on parallel history Append (rather than overwrite) history.
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
history -a

###############################################################################
# Constants
[[ -z "${TRUE:-}" ]] && export readonly  TRUE=0
[[ -z "${FALSE:-}" ]] && export readonly  FALSE=1

###############################################################################
## Miscellaneous GIT Environment Properties
#export GIT_SSH_COMMAND="ssh -vvv"

# gradle
GRADLE_USER_HOME="${HOME}/.gradle"
export GRADLE_USER_HOME

# PyCharm IDE exported from Windows 11
# required by Claude Code /ide
#export IDE_PATH="/mnt/c/dev/ide/pycharm/bin/pycharm64.exe"

# IntelliJ IDE exported from Windows 11
# required by Claude Code /ide
#export IDE_PATH="/mnt/c/ide/intellij/bin/idea64.exe"

# util-linux compilers paths
# export LDFLAGS="-L/usr/local/opt/util-linux/lib"
# export CPPFLAGS="-I/usr/local/opt/util-linux/include"

source  ~/.secrets
source  ~/.bashrc

