function composer
  set tty --tty
  docker run \
    $tty \
    --interactive \
    --rm \
    --net=host \
    --user (id -u):(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume (pwd):/app \
    --volume /home/(id -un):/home/(id -un) \
    -e COMPOSER_HOME="/home/(id -un)/.composer" \
    composer $argv
end
