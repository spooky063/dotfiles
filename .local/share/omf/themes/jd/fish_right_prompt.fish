# Svn
function __jd_svn_is -d 'Check if path is svn directory'
  test -d .svn; or command svn info >/dev/null ^/dev/null
end

function __jd_svn_prompt -d 'Prompt svn'
  if __jd_svn_is
    set -l current_revision (command svn info --show-item revision | sed 's: ::g' ^/dev/null)

    __jd_svn_color
    echo '('

    printf '%s ' (__jd_svn_branch)

    echo 'r'
    if begin; test (__jd_svn_rev) -gt 0; end
      echo '-'(__jd_svn_rev)
    end
    echo '='$current_revision

    echo ')'
    set_color normal
    echo ' '
  end
end

function __jd_svn_color -d 'Set svn color according to status'
  if [ __jd_svn_rev != 0 ]
    set_color red
  else
    set_color green
  end
end

function __jd_svn_rev -d 'Print svn revisions'
  set -l url_repo (command svn info | grep '^URL' | sed -r 's/^.{6}//')
  set -l last_revision (command svn log -l 1 (echo $url_repo) | head -n 2 | cut -f 1 -d '|' | sed 's=[^0-9:]*==g' ^/dev/null)
  set -l current_revision (command svn info --show-item revision | sed 's: ::g' ^/dev/null)
  echo (math $last_revision - $current_revision)
end

function __jd_svn_branch -d 'Print svn branch'
  printf '%s' (command svnpath | egrep -o '(tags|branches)/[^/]+|trunk')
end

# Git
function __jd_git_is -d 'Check if path is git directory'
  test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function __jd_git_prompt -d "Gets the current git status"
  if __jd_git_is
    set -l branch (command git symbolic-ref --short HEAD ^/dev/null; or git show-ref --head -s --abbrev | head -n1 ^/dev/null)
    set -l changedFiles (command git diff --name-status ^/dev/null | string match -r \\w)
    set -l stagedFiles (command git diff --staged --name-status | string match -r \\w)
    set -l stashed (command git stash list ^/dev/null | string match -r \\w)
    set -l untrackedfiles (command git ls-files --others --exclude-standard | wc -l | string trim)

    set -l x (count $changedFiles)
    set -l y (count (string match -r "U" -- $changedFiles))
    set -l dirtystate (math $x - $y)
    set -l z (count $stagedFiles)
    set -l s (count $stashed)
    set -l invalidstate (count (string match -r "U" -- $stagedFiles))
    set -l stagedstate (math $x - $invalidstate)
    set -l totaluntrackedfiles (math $x + $z + $untrackedfiles)

    if [ "$dirtystate" != "0" ]
      set_color red
    else if [ "$totalcommits" != "0" ]
      set_color yellow
    else
      set_color green
    end

    echo '('
    echo $branch
    echo ' '
    if [ "$s" != "0" ]
      echo '^'
    end
    if [ "$z" != "0" ]
      echo '+'$z
    end
    if [ "$x" != "0" ]
      echo '*'$x
    end
    if [ "$untrackedfiles" != "0" ]
      echo '%'
    end
    if [ "$totaluntrackedfiles" = "0" ]
      echo '$'
    end
    echo ' u'
    if test (command git rev-list --count --left-right '@{upstream}...HEAD' ^/dev/null)
      set -l commit_count (command git rev-list --count --left-right '@{upstream}...HEAD' ^/dev/null)
      set -l commits_to_pull (echo $commit_count | cut -f 1 ^/dev/null)
      set -l commits_to_push (echo $commit_count | cut -f 2 ^/dev/null)

    	switch "$commit_count"
      case ""
    	  # no upstream
      case "0"\t"0"
    	  test -n "$none"; and echo "$none"; or echo "="
      case "*"\t"0"
    	  test -n "$behind"; and echo "$behind"; or echo "-"$commits_to_pull
      case "0"\t"*"
    	  test -n "$ahead"; and echo "$ahead"; or echo "+"$commits_to_push
      case "*"
    	  test -n "$diverged"; and echo "$diverged"; or echo "±"
    	end
    else
      echo "±"
    end
    echo ')'
    set_color normal
    echo ' '
  end
end

function __jd_date -d "Prints current date"
  set_color $fish_color_autosuggestion ^/dev/null; or set_color 555
  printf '%s' (date "+%H:%M:%S")
  set_color normal
end

function fish_right_prompt -d "Prints right prompt"
  __jd_svn_prompt
  __jd_git_prompt
  __jd_date
end
