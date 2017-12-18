#!/usr/bin/env fish

function composer
	docker run \
      --tty \
      --interactive \
      --rm \
      --volume $PWD:/app \
      composer $argv
end
