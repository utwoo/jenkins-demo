#! /bin/bash -e

fn-check-changelog-ticket() {
    local no_ticket_regex="* \[NoTicket\]:"                     # '* [NoTicket]:'
    local jira_ticket_regex="* \[[A-Za-z]\{1,\}-[0-9]\{1,\}\]:" # '* [ABC-123456]:'
    local github_issue_regex="* \[#[0-9]\{1,\}\]:"              # '* [#123]:'

    local invalid_records="$(cat ./CHANGELOG.md | grep -n "*" | grep -i -v "${no_ticket_regex}\|${jira_ticket_regex}\|${github_issue_regex}")"

    if [[ "${invalid_records}" != "" ]]; then
        echo "[check-changelog] FAIL: please specify a ticket/issue number for the following records in the format:"
        echo "* [<Jira_ticket>/<Github_issue>/NoTicket]: <Record message>"
        echo "${invalid_records}"
        exit 1
    fi

    echo "[check-changelog] OK: ticket reference included in CHANGELOG.md updates"

    exit 0
}

fn-check-changelog-ticket "$@"
