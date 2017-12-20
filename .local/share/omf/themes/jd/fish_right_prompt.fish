function git_status --description "Gets the current git status"
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
end

function git_is
  test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function fish_right_prompt -d "Prints right prompt"
  if git_is
    git_status
    echo ' '
  end

  set_color $fish_color_autosuggestion ^/dev/null; or set_color 555
  date "+%H:%M:%S"
  set_color normal
end
