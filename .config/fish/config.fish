source $HOME/.config/fish/aliases.fish

set -gx fish_greeting ''

set -gx EDITOR vim

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "+"
set -g __fish_git_prompt_char_upstream_behind "-"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_char_dirtystate "*"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold

function fish_prompt --description 'JD'
  set -l last_status $status

  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (set_color blue)(hostname|cut -d . -f 1)(set_color normal)
  end

  if not set -q __fish_prompt_normal
      set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_color_red
      set -g __fish_color_red (set_color red)
  end

  if not set -q __fish_color_yellow
      set -g __fish_color_yellow (set_color yellow)
  end

  if not set -q __fish_color_blue
      set -g __fish_color_blue (set_color blue)
  end

  if not set -q __fish_color_magenta
      set -g __fish_color_magenta (set_color magenta)
  end

  if not set -q __fish_color_cyan
      set -g __fish_color_cyan (set_color cyan)
  end

  #Set the color for the status depending on the value
  set __fish_color_status (set_color green)
  if test $last_status -gt 0
      set __fish_color_status (set_color red)
  end

  switch "$USER"

    case root toor

      if not set -q __fish_prompt_cwd
          if set -q fish_color_cwd_root
              set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
          else
              set -g __fish_prompt_cwd (set_color $fish_color_cwd)
          end
      end

      printf '%s@%s %s%s%s # ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    case '*'

      if not set -q __fish_prompt_cwd
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end

      echo -e "$__fish_color_magenta"[(date +"%H:%M:%S")] "$__fish_color_yellow""$USER""$__fish_color_red""@""$__fish_prompt_hostname" "$__fish_prompt_cwd"(__fish_git_prompt) "$__fish_color_cyan""$PWD" "$__fish_prompt_normal" "\r\n> "
  end

end
