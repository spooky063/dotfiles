GRAY="\[\e[01;30m\]"
CYAN="\[\033[00;36m\]"
YELLOW="\[\033[38;5;226m\]"
ORANGE="[\033[38;5;166m\]"
PURPLE="\[\033[38;5;99m\]"
RED_BOLD="\[\033[01;31m\]"

if [ "$color_prompt" = yes ]; then
    export SVN_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWDIRTYSTATE=yes
    GIT_PROMPT_ONLY_IN_REPO=1
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;30m\]\t \[\033[38;5;226m\]\u\[\033[38;5;166m\]@\[\033[38;5;99m\]\h\[\033[01;31m\]$(__svn_stat)$(__git_ps1) \[\033[00;36m\]\w \[\033[00m\]\n$ '

  if [ ! $SVNP_HUGE_REPO_EXCLUDE_PATH ]; then
		SVNP_HUGE_REPO_EXCLUDE_PATH="/tags$|/branches$"
	fi
    __svn_rev ()
	{
		LANG='C' svn info 2>/dev/null | awk '/Revision:/ {print $2; }'
	}
	__svn_last_changed ()
	{
		LANG='C' svn info 2>/dev/null | awk '/Last Changed Rev:/ { print $4;}'
	}
	__svn_clean ()
	{
		if [ $SVNP_HAVE_HUGE_REPO ]; then
			HUGE_REPO=" -N ";
		else
			pwd | egrep -q -s $SVNP_HUGE_REPO_EXCLUDE_PATH && HUGE_REPO=" -N "
		fi
		STATE=$(LANG='C' svn $HUGE_REPO status -q 2>/dev/null | grep "^[MA]" | wc -l)
		if [ $STATE != 0 ]; then
			echo "$2"
		else
			echo "$1"
		fi
	}
	__svn_remote_clean ()
	{
		if [ $SVNP_HAVE_HUGE_REPO ]; then
			HUGE_REPO=" -N ";
		else
			pwd | egrep -q -s $SVNP_HUGE_REPO_EXCLUDE_PATH && HUGE_REPO=" -N "
		fi
		STATE=$(LANG='C' svn $HUGE_REPO status -u -q 2>/dev/null | egrep -q -s " *\*" | wc -l)
		if [ $STATE != 0 ]; then
			echo "$2"
		else
			echo "$1"
		fi
	}
	__svn_stat ()
	{
		REV=$(__svn_rev)
		if [ $REV ]; then
			if [ $SVNP_CHECK_DISTANT_REPO ]; then
				REMOTE_STATUS=$(__svn_remote_clean "" "*")
			fi
			LOCAL_STATUS=$(__svn_clean "" "*")
			echo " (SVN:r"$REMOTE_STATUS$REV$LOCAL_STATUS")"
		fi
	}

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
