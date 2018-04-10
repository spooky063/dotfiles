function servername
    host (dig +short $argv)  | awk '{print $5}' | awk '{ print substr($0,1,length($0)-1) }'
end
