[ -r /etc/bashrc ] && source /etc/bashrc
[ -r /etc/bash_completion ] && source /etc/bash_completion

# If not already exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# GIT or SVN
__has_parent_dir () {
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}

__vcs_name() {
    if [ -d .svn ]; then
        echo " (svn)";
    elif __has_parent_dir ".git"; then
        echo "$(__git_ps1 ' (%s)')";
    elif __has_parent_dir ".hg"; then
        echo "$(hg branch)"
    fi
}

##
# PS1
##
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_HIDE_IF_PWD_IGNORED=1
export PS1='\[\e[0;91m\]\t \[\e[38;5;226m\]\u\[\e[38;5;166m\]@\[\e[38;5;99m\]\h\[\e[01;33m\]$(__vcs_name) \[\e[00;36m\]\w \[\e[0m\]\n$ '
export GIT_MERGE_AUTOEDIT=no
