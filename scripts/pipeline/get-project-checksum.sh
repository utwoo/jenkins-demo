#! /bin/bash -ex

# gets the checksum of a directory's files, excluding bin and obj
fn-get-project-checksum() {
    local project=$1

    find "./${project}" -type f \
        -not -path "./obj*" \
        -not -path "./bin*" \
        -exec shasum {} + | sort | shasum | awk '{ print $1 }'
}

fn-get-project-checksum "$@"
