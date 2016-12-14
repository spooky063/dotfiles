#------------------------------------------////
# Default:
#------------------------------------------////
alias cls='clear'
alias ps='ps aux'
alias x='exit'
alias s='sudo -i'
alias df='df -h'
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'
alias grep='grep --color=auto -in'

#------------------------------------------////
# Compatibility:
#------------------------------------------////
alias del='rm'
alias dir='ls -la'

#------------------------------------------////
# Listing:
#------------------------------------------////
alias ls='ls -F --color=always'
alias ll='ls -lh'
alias lt='ls -alt'
alias la='ls -A'
alias lla='ls -Alh'
alias lat='ls -alt'
alias ltr='ls -altr'
alias latr='ls -altr'

#------------------------------------------////
# System:
#------------------------------------------////
alias shutdown='sudo shutdown –h now'
alias restart='sudo shutdown –r now'
alias suspend='sudo pm-suspend'
alias lock='gnome-screensaver-command --lock'

#------------------------------------------////
# Directory:
#------------------------------------------////
alias documents='cd ~/Documents'
alias downloads='cd ~/Téléchargements'
alias desktop='cd ~/Bureau'
alias music='cd ~/Musique'
alias videos='cd ~/Videos'

alias www='cd /var/www'
alias cds='cd ~ && clear'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#------------------------------------------////
# Clear Memory
# --> ONLY ROOT USER
#------------------------------------------////
alias dropmem='dropram && dropswap && dropram'
alias dropram='sync && echo 3 > /proc/sys/vm/drop_caches'
alias dropswap='swapoff -a && swapon -a'

#------------------------------------------////
# Docker:
#------------------------------------------////
alias npmi='docker run --rm -v $(pwd):/opt node-tools npm install $1'
alias gulp='docker run --rm -v $(pwd):/opt node-tools gulp $1'
alias grunt='docker run --rm -v $(pwd):/opt node-tools grunt $1'

#------------------------------------------////
# Custom Extract / Compress:
#------------------------------------------////
# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
