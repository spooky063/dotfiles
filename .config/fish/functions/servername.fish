function servername
    if begin; test (command curl -o -I -L -s -w '%{http_code}\n' $argv) -eq 200; end
        host (dig +short $argv)  | awk '{print $5}' | awk '{ print substr($0,1,length($0)-1) }'
    else if begin; test (command curl -o -I -L -s -w '%{http_code}\n' $argv) -eq 401; end
        echo 'Website is protected'
    else
        echo 'Website is down'
    end
end
