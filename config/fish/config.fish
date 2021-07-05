source $HOME/.config/fish/aliases.fish

set -gx fish_greeting ''
set -gx EDITOR vim

set -U fish_user_paths $HOME/.config/composer/vendor/bin/ $fish_user_paths
set -U fish_user_paths /home/linuxbrew/.linuxbrew/bin/ $fish_user_paths
