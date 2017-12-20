function fish_prompt --description 'Theme JD'
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

  if test "$theme_complete_path" = "yes"
    set cwd (prompt_pwd)
  else if test "$theme_short_path" = "yes"
    set cwd (basename (prompt_pwd))
  else
      set cwd (prompt_pwd)
  end

  switch "$USER"
    case root toor
      echo -e "$__fish_color_yellow""$USER""$__fish_prompt_normal":"$__fish_color_cyan"$cwd "$__fish_prompt_normal" "\r\n# "

    case '*'
      echo -e "$__fish_color_yellow""$USER""$__fish_prompt_normal":"$__fish_color_cyan"$cwd "$__fish_prompt_normal" "\r\n> "
  end

end
