# Svn
function __jd_svn_prompt -d 'Prompt svn'
  if __jd_svn_is
    if begin; not command svn info | grep 'too old' >/dev/null ^/dev/null; end
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
end

function __jd_svn_is -d 'Check if path is svn directory'
  test -d .svn; or command svn info >/dev/null ^/dev/null
end

function __jd_svn_color -d 'Set svn color according to status'
  if begin; test (__jd_svn_rev) -gt 0; end
    set_color red
  else
    set_color green
  end
end

function __jd_svn_branch -d 'Print svn branch'
  printf '%s' (command svnpath | egrep -o '(tags|branches)/[^/]+|trunk')
end

function __jd_svn_rev -d 'Print svn revisions'
  set -l url_repo (command svn info | grep '^URL' | sed -r 's/^.{6}//')
  set -l last_revision (command svn log -l 1 (echo $url_repo) | head -n 2 | cut -f 1 -d '|' | sed 's=[^0-9:]*==g' ^/dev/null)
  set -l current_revision (command svn info --show-item revision | sed 's: ::g' ^/dev/null)
  echo (math $last_revision - $current_revision)
end

# Git
function __jd_git_prompt -d "Gets the current git status"
  if __jd_git_is
    if begin; test (__jd_git_dirty_count) -gt 0; or test (__jd_git_staged_count) -gt 0; end
      set_color red
    else if begin; test (__jd_git_commit_count) -gt 0; end
      set_color yellow
    else
      set_color green
    end

    echo '('
    echo (__jd_git_branch)
    echo ' '
    if begin; test (__jd_git_stashed) -gt 0; end
      echo '^'
    end
    if begin; test (__jd_git_staged) -gt 0; end
      echo '+'(__jd_git_staged)
    end
    if begin; test (__jd_git_dirty) -gt 0; end
      echo '*'(__jd_git_dirty)
    end
    if begin; test (__jd_git_untracked) -gt 0; end
      echo '%'
    end
    if begin; test (__jd_git_untracked_count) -eq 0; end
      echo '$'
    end
    echo ' u'
    if test (command git rev-list --count --left-right '@{upstream}...HEAD' ^/dev/null)
    	switch (__jd_git_commit)
      case ""
    	  # no upstream
      case "0"\t"0"
    	  echo "="
      case "*"\t"0"
    	  echo "-"(__jd_git_commit_pull)
      case "0"\t"*"
    	  echo "+"(__jd_git_commit_push)
      case "*"
    	  echo "±"
    	end
    else
      echo "±"
    end
    echo ')'
    set_color normal
    echo ' '
  end
end

function __jd_git_is -d 'Check if path is git directory'
  test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function __jd_git_branch -d 'Print git branch'
  if __jd_git_is
    printf '%s' (command git symbolic-ref --short HEAD ^/dev/null; or git show-ref --head -s --abbrev | head -n1 ^/dev/null)
  end
end

function __jd_git_commit -d 'Print the number of revision between upstream and HEAD'
  if __jd_git_is
    printf '%s' (command git rev-list --count --left-right '@{upstream}...HEAD' ^/dev/null)
  end
end

function __jd_git_commit_pull -d 'Print the number of commit to pull'
  if __jd_git_is
    printf '%d' (echo (__jd_git_commit) | cut -f 1 ^/dev/null)
  end
end

function __jd_git_commit_push -d 'Print the number of commit to push'
  if __jd_git_is
    printf '%d' (echo (__jd_git_commit) | cut -f 2 ^/dev/null)
  end
end

function __jd_git_commit_count -d 'Print the number of commit to pull and push'
  printf '%d' (math (__jd_git_commit_pull) + (__jd_git_commit_push))
end

function __jd_git_dirty -d 'Print the number of file changed'
  if __jd_git_is
    set -l changedFiles (command git diff --name-status ^/dev/null | string match -r \\w)
    printf '%d' (count $changedFiles)
  end
end

function __jd_git_dirty_count -d 'Print the total number of file changed'
  if __jd_git_is
    set -l changedFiles (command git diff --name-status ^/dev/null | string match -r \\w)
    set -l x (count $changedFiles)
    set -l y (count (string match -r "U" -- $changedFiles))
    printf '%d' (math $x - $y)
  end
end

function __jd_git_staged -d 'Print the number of file staged'
  if __jd_git_is
    set -l stagedFiles (command git diff --staged --name-status | string match -r \\w)
    printf '%d' (count $stagedFiles)
  end
end

function __jd_git_staged_count -d 'Print the total number of file staged'
  if __jd_git_is
    set -l stagedFiles (command git diff --staged --name-status | string match -r \\w)
    set -l x (count $stagedFiles)
    set -l y (count (string match -r "U" -- $stagedFiles))
    printf '%d' (math $x - $y)
  end
end

function __jd_git_untracked -d 'Print the number of file untracked'
  if __jd_git_is
    printf '%d' (command git ls-files --others --exclude-standard | wc -l | string trim)
  end
end

function __jd_git_untracked_count -d 'Print the total number of file untracked'
  printf '%d' (math (__jd_git_dirty) + (__jd_git_staged) + (__jd_git_untracked))
end

function __jd_git_stashed -d 'Print the number of file stashed'
  if __jd_git_is
    set -l stashed (command git stash list ^/dev/null | string match -r \\w)
    printf '%d' (count $stashed)
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
