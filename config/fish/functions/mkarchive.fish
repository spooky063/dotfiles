function mktar --description 'Create .tar archive from directory.'
    if contains -- "$argv[1]" -h --help
        set scriptname mktar
        echo "Usage: $scriptname [directory]"
        echo "Create .tar archive from directory."
        return 0
    end

    if test (count $argv) -lt 2
        echo "Usage: mktar archive-name directory1 directory2 ..."
        return 1
    end

    set archive_name (string trim --right --chars=/ $argv[1])
    set directories $argv[2..-1]

    tar cvf "$archive_name.tar" $directories
end

function mktgz --description 'Create .tar.gz archive from directory.'
    if contains -- "$argv[1]" -h --help
        set scriptname mktar
        echo "Usage: $scriptname [directory]"
        echo "Create .tar.gz archive from directory."
        return 0
    end

    if test (count $argv) -lt 2
        echo "Usage: mktar archive-name directory1 directory2 ..."
        return 1
    end

    set archive_name (string trim --right --chars=/ $argv[1])
    set directories $argv[2..-1]

    tar cvzf "$archive_name.tar.gz" $directories
end

function mktbz --description 'Create .tar.bz2 archive from directory.'
    if contains -- "$argv[1]" -h --help
        set scriptname mktar
        echo "Usage: $scriptname [directory]"
        echo "Create .tar.bz2 archive from directory."
        return 0
    end

    if test (count $argv) -lt 2
        echo "Usage: mktar archive-name directory1 directory2 ..."
        return 1
    end

    set archive_name (string trim --right --chars=/ $argv[1])
    set directories $argv[2..-1]

    tar cvjf "$archive_name.tar.bz2" $directories
end