#!/usr/bin/env bash
# Rubens personal shell environment profile
#

######################################################################
## JAVA_HOME
# only java 21 is installed on my Ubuntu linux
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

######################################################################
## PATH 
PATH="\
${HOME}/.local/bin:\
${HOME}/bin:\
${HOME}/bin/tools:\
/opt/gradle/bin:\
/opt/maven/bin:\
/usr/local/bin:\
/bin:\
/usr/bin:\
/sbin:\
/usr/sbin:\
${PATH}"

######################################################################
## Constants
[[ -z "${TRUE:-}" ]] && export readonly  TRUE=0
[[ -z "${FALSE:-}" ]] && export readonly  FALSE=1

######################################################################
## Miscellaneous GIT Environment Properties
#export GIT_SSH_COMMAND="ssh -vvv"

######################################################################
## gradle
export GRADLE_USER_HOME="${HOME}/.gradle"

######################################################################
## JetBrains + Claude Code
# PyCharm IDE exported from Windows 11
# required by Claude Code /ide
#export IDE_PATH="/mnt/c/dev/ide/pycharm/bin/pycharm64.exe"
# IntelliJ IDE exported from Windows 11
# required by Claude Code /ide
#export IDE_PATH="/mnt/c/ide/intellij/bin/idea64.exe"

######################################################################
## secrets
source  ~/.secrets

######################################################################
## .bashrc
source  ~/.bashrc

