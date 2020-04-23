# Include
[ -r /etc/bashrc ] && source /etc/bashrc
[ -r /etc/bash_completion ] && source /etc/bash_completion
[ -r $HOME/.bash.aliases ] && source $HOME/.bash.aliases
[ -r $HOME/.bash.functions ] && source $HOME/.bash.functions

# Color Palette
RESET='\033[0m'
BOLD='\033[1m'

## Foreground
BLACK='\033[38;5;0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
BLUE='\033[38;5;4m'
MAGENTA='\033[38;5;5m'
CYAN='\033[38;5;6m'
WHITE='\033[38;5;7m'

## Background
ON_BLACK='\033[48;5;0m'
ON_RED='\033[48;5;1m'
ON_GREEN='\033[48;5;2m'
ON_YELLOW='\033[48;5;3m'
ON_BLUE='\033[48;5;4m'
ON_MAGENTA='\033[48;5;5m'
ON_CYAN='\033[48;5;6m'
ON_WHITE='\033[48;5;7m'

# GIT
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_HIDE_IF_PWD_IGNORED=1

# PS1
type __vcs_name &>/dev/null \
  && export PS1="$MAGENTA[\A] $YELLOW\u$RED@$BLUE\h$RED\$(__vcs_name) $CYAN\w $RESET\n$ " \
  || export PS1="$MAGENTA[\A] $YELLOW\u$RED@$BLUE\h$RED $CYAN\w $RESET\n$ "

# History
export HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='&:x:s:df:du:ls*:ll*:lt*:la*:lla*:lat*:ltr*:latr*:www:cds:cd*:..:exit:history'
shopt -s histappend
PROMPT_COMMAND='history -a'
