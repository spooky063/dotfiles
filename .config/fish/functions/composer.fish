function composer
	set tty --tty
	set home (id -un)
	docker run \
		$tty \
		--interactive \
    --rm \
		--net=host \
    --user (id -u):(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume (pwd):/app \
		--volume /home/$home:/home/$home \
		-e COMPOSER_HOME="/home/$home/.composer" \
    composer $argv
end
