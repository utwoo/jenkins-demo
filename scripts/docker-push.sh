#! /bin/bash -e

fn-push() {
    local registry=$1
    local image_name=$2
    local current_tag="$(cat ./current-tag | tr -d '\n')"

    docker push $registry/$image_name:$current_tag
    docker push $registry/$image_name:latest

    sleep 5
    exit 0
}

fn-push "$@"