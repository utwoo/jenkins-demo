#! /bin/bash -e

fn-build() {
    local registry=$1
    local image_name=$2
    local current_tag="$(cat ./current-tag | tr -d '\n')"
    docker build -f ./Dockerfile --tag $registry/$image_name:$current_tag --tag $registry/$image_name:latest .
}

fn-build "$@"