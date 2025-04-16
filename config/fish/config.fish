source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions/mkarchive.fish

set -gx fish_greeting ''
set -gx EDITOR vim
set -gx fish_autosuggestion_enabled 1

function add_to_path
    if test -d $argv[1]
        set -gx PATH $argv[1] $PATH
    end
end

add_to_path /bin
add_to_path /usr/bin
add_to_path /usr/local/go/bin

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
