function md --description 'Render markdown file into terminal.'
    if contains -- "$argv[1]" -h --help
        set scriptname md
        echo "Usage: $scriptname [file].md"
        echo "Render markdown file into terminal."
        return 0
    end

    pandoc $argv | lynx -stdin
end
