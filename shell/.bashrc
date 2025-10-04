######################################################################
## HISTORY
# History settings

# force bash to append instead of overwriting
shopt -s histappend

# no duplicates at all
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=5000
export HISTFILESIZE=10000

# Sync history in real time
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


#####################################################################
## PROMPT PS1
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    PS1='\[\033[01;32m\]\u@wsl \W \[\033[01;34m\]\[\033[00m\]\$ '
else
    PS1='\u@wsl \W \$ '
fi

#####################################################################
# alias definitions.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

#####################################################################
# enable bash completion
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

