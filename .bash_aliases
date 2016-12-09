# Default
alias cls='clear'
alias ps='ps aux'
alias x='exit'
alias s='sudo -i'
alias df='df -h'
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'
alias grep='grep --color=auto -in'

# Compatibility
alias del='rm'
alias dir='ls -la'

# LS
alias ls='ls -F --color=always'
alias ll='ls -lh'
alias lt='ls -alt'
alias la='ls -A'
alias lla='ls -Alh'
alias lat='ls -alt'
alias ltr='ls -altr'
alias latr='ls -altr'

# System
alias shutdown='sudo shutdown –h now'
alias restart='sudo shutdown –r now'
alias suspend='sudo pm-suspend'
alias lock='gnome-screensaver-command --lock'

# Directory
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

# Custom
alias maxmem='ps aux  | awk '{print $6/1024 " MB\t\t" $11}'  | sort -rn | head -20'

# Clear Memory
# Only root user
alias dropmem='dropram && dropswap && dropram'
alias dropram='sync && echo 3 > /proc/sys/vm/drop_caches'
alias dropswap='swapoff -a && swapon -a'

# Docker configuration
alias npmi='docker run --rm -v $(pwd):/opt node-tools npm install $1'
alias gulp='docker run --rm -v $(pwd):/opt node-tools gulp $1'
alias grunt='docker run --rm -v $(pwd):/opt node-tools grunt $1'
