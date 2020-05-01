#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage: $(basename $0) <manifest.ext>"
    exit 2
fi

APP_NAME=$(echo "$1" | sed 's:.yaml\|.yml\|.json\|./\|\n::g')
N_JOBS=$(nproc --ignore=1)

set -xe

flatpak-builder --install \
                --user \
                --default-branch=test \
                --force-clean \
                --ccache \
                --jobs=${N_JOBS} \
                --disable-updates \
                .app-dir \
                "$1"

flatpak run --branch=test ${APP_NAME}
