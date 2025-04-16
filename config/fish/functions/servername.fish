function servername --description 'Get the server name related to the IP or or inversely.'
    if contains -- "$argv[1]" -h --help
        set scriptname memory
        echo "Usage: $scriptname [process]"
        echo "Get the server name related to the IP or or inversely."
        return 0
    end

    if begin; test (command curl -o -I -L -s -w '%{http_code}\n' $argv) -eq 200; end
        set -l ip (command dig +short $argv  | head -n 1)
        set -l ipv4 (string match -ir '^[0-9\.]+$' $ip)
        if begin; test (string length $ipv4); end
                host (dig +short $argv)  | awk '{print $5}' | awk '{ print substr($0,1,length($0)-1) }'
        end
    else if begin; test (command curl -o -I -L -s -w '%{http_code}\n' $argv) -eq 401; end
        echo 'Website is protected'
    else
        echo 'Website is down'
    end
end
