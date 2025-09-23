#####################################################################
## PROMPT PS1
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    PS1='\[\033[01;32m\]\u@wsl \[\033[01;34m\]\[\033[00m\]\$ '
else
    PS1='\u@wsl\$ '
fi

#####################################################################
# alias definitions.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

#####################################################################
# enable bash completion
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

