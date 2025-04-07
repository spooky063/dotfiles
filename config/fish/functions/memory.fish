function memory
    ps aux | grep $argv | grep -v grep | awk '
    BEGIN { sum=0 }
    { sum += $6 }
    END {
        if (sum >= 1048576)
            printf("Taille RAM utilisée: %.2f Go\n", sum / 1048576)
        else
            printf("Taille RAM utilisée: %.2f Mo\n", sum / 1024)
    }'
end