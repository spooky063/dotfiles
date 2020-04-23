#!/bin/bash

set -Ee

yellow=`tput setaf 3`
reset=`tput sgr0`

ln() {
  local DIR=`pwd`/config
  local FILENAME=${DIR}/config.list
  test -f ${FILENAME} || exit

  echo "For install all your configuration, please copy and paste the following command"
  echo "$yellow"
  while IFS= read -r line; do
   echo "ln -s $DIR/$line &&"
  done < ${FILENAME}
  echo "echo 'Done!'"
  echo "$reset"
}

ln
