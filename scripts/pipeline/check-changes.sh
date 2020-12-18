#! /bin/bash -ex

source ./scripts/pipeline/get-project-checksum.sh

fn-check-change() {
    local mesh_app_name=$1
    local branch=$2
    local src_dir_sha=$(fn-get-project-checksum)
    local branch_src_dir_sha=$(consul kv get pipeline-data/${mesh_app_name}/${branch}/src-dir-sha || echo "")

    echo "[check-tag-change] /src/ shasum on ${branch}:      ${branch_src_dir_sha}"
    echo "[check-tag-change] /src/ shasum on current branch: ${src_dir_sha}"

    if [[ "${src_dir_sha}" == "${branch_src_dir_sha}" ]]; then
        echo "[check-tag-change] no changes in /src/ - no expectation that current-tag is changed"
        exit 0
    fi

    echo "[check-tag-change] found changes in /src/ - ensuring current-tag has changed..."

    local current_tag=$(cat ./current-tag | tr -d '\n')
    local branch_current_tag=$(consul kv get pipeline-data/${mesh_app_name}/${branch}/current-tag)

    echo "[check-tag-change] current=${current_tag} ${branch}=${branch_current_tag}"

    if [[ "${current_tag}" == "${branch_current_tag}" ]]; then
        echo "[check-tag-change] FAIL: Please increment the version in the 'current-tag' file."
        exit 1
    fi

    echo "[check-tag-change] OK: current-tag has changed"
    exit 0
}

fn-check-tag-change "$@"