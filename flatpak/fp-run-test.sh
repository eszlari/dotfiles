#!/bin/bash

set -e

if [ -f /.flatpak-info ]; then
  TEST_XDG_HOME=~/.var/app/${FLATPAK_ID}/test
  rm -rf ${TEST_XDG_HOME}
  mkdir -pv ${TEST_XDG_HOME}
  export XDG_CONFIG_HOME=${TEST_XDG_HOME}/config
  export XDG_CACHE_HOME=${TEST_XDG_HOME}/cache
  export XDG_DATA_HOME=${TEST_XDG_HOME}/data
  COMMAND=$(awk -F "=" '/Exec/ {print $2}' /app/share/applications/${FLATPAK_ID}.desktop | cut -d ' ' -f1)
  exec ${COMMAND} "$@"
fi

flatpak run --branch=test --filesystem=~/bin:ro --command=${HOME}/bin/fp-run-test.sh "$@"
