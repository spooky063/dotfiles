source $HOME/.config/fish/aliases.fish

set -gx fish_greeting ''
set -gx EDITOR vim

set -U fish_user_paths $HOME/.config/composer/vendor/bin/ $fish_user_paths
set -U fish_user_paths /home/linuxbrew/.linuxbrew/bin/ $fish_user_paths

function add_to_path
    if test -d $argv[1]
        set -gx PATH $argv[1] $PATH
    end
end

add_to_path /bin
add_to_path /usr/bin

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
