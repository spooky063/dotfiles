# If not already exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##
# Enable programmable completion features GIT
##
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

##
# PS1
##
if [ "$color_prompt" = yes ]; then
  export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch GIT_PS1_SHOWCOLORHINTS=1
  export GIT_PS1_HIDE_IF_PWD_IGNORED=1
  export PS1='\[\e[0;91m\]\t \[\e[38;5;226m\]\u\[\e[38;5;166m\]@\[\e[38;5;99m\]\h\[\e[01;33m\]$(__git_ps1 " (%s)") \[\e[00;36m\]\w \[\e[0m\]\n$ '
  export GIT_MERGE_AUTOEDIT=no
else
  export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
