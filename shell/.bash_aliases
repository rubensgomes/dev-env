# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
  alias ls='ls --color=auto'
  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"

alias antlr4="java -jar /opt/antlr4/lib/antlr-4.13.2-complete.jar"
