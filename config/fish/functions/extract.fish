function extract --description 'Extract archive to current directory.'
    if contains -- "$argv[1]" -h --help
        set scriptname extract
        echo "Usage: $scriptname [file]"
        echo "Extract archive files (.zip, .tar.gz, .rar, etc.)"
        return 0
    end

    if test -f $argv
        switch $argv
            case '*.tar.bz2' '*.tbz2'
                tar xvjf $argv
            case '*.tar.gz' '*.tgz'
                tar xvzf $argv
            case '*.bz2'
                bunzip2 $argv
            case '*.rar'
                rar x $argv
            case '*.gz'
                gunzip $argv
            case '*.tar'
                tar xvf $argv
            case '*.zip'
                unzip $argv
            case '*.Z'
                uncompress $argv
            case '*.7z'
                7z x $argv
            case '*'
                echo "don't know how to extract '$argv'..."
        end
    else
        echo "'$argv' is not a valid file!"
    end
end