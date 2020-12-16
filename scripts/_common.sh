#! /bin/bash -e

fn-set-current-version() {
    if [[ "${SERVICE_CURRENT_VERSION}" == "" ]]; then
        export SERVICE_CURRENT_VERSION = $(cat ./current-tag | tr -d '\n')
    fi
}
