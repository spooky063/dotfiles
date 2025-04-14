# Default
alias cls='clear'
alias ps='ps aux'
alias x='exit'
alias s='sudo -i'
alias df='df -H'
alias du='du -ch'
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'
alias mkdir='mkdir -p'
alias ping='ping -c 4'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias aptlist='cat /etc/apt/sources.list{,.d/*} 2>/dev/null | grep -v "^#"'
alias myip='curl http://ipecho.net/plain; echo'

# Compatibility
alias del='rm'
alias dir='ls -la'

# Listing
if type -q eza
    #alias ls='eza --time-style "+%Y-%m-%d %H:%M"'
    alias ll='eza --git -glSrh --time-style "+%Y-%m-%d %H:%M"'
    alias la='eza --git -gA --time-style "+%Y-%m-%d %H:%M"'
    alias lla='eza --git -gAlh --time-style "+%Y-%m-%d %H:%M"'
    alias lat='eza --git -gAl --sort newest --time-style "+%Y-%m-%d %H:%M"'
    alias latr='eza --git -gAl --sort oldest --time-style "+%Y-%m-%d %H:%M"'

    alias tree='eza -lah --total-size --color always --time-style "+%Y-%m-%d %H:%M" --icons=never -T'
else
    alias ls='ls -F --color=always'
    alias ll='ls -lSrh'
    alias la='ls -A'
    alias lla='ls -Alh'
    alias lat='ls -alt'
    alias latr='ls -altr'
end

# System
alias shutdown='sudo systemctl poweroff -i'
alias restart='sudo systemctl reboot -i'
alias suspend='sudo pm-suspend'
alias lock='gnome-screensaver-command --lock'

# Directory
alias documents='cd ~/Documents'
alias downloads='cd ~/Téléchargements'
alias desktop='cd ~/Bureau'
alias music='cd ~/Musique'
alias videos='cd ~/Videos'
alias cds='cd ~; clear'

# Move to parent directory
alias ..='cd ..'
alias 1.='cd ..'
alias ...='cd ../..'
alias 2.='cd ../..'
alias ....='cd ../../..'
alias 3.='cd ../../..'
alias .....='cd ../../../..'
alias 4.='cd ../../../..'
alias ......='cd ../../../../..'
alias 5.='cd ../../../../..'
alias .......='cd ../../../../../..'
alias 6.='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias 7.='cd ../../../../../../..'

# Clear log files
alias clearlog='sudo find /var/log/ \( -iregex ".*\.[0-9]+" -o -iname "*.gz" \) -exec rm {} \;'

# See 15 biggest file from system
alias sd='sudo du -hs /* | sort -h | tail -15'

# Docker
alias dockerps='docker ps -as --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Size}}"'
