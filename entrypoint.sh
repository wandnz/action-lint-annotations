#!/bin/bash

set -euo pipefail

if [ "${PROBLEM_MATCHERS}" = "*" ]; then
    matchers="$(find "${GITHUB_ACTION_PATH}/matchers/" -name "*.json" -exec basename {} .json \;)"
else
    matchers="${PROBLEM_MATCHERS}"
fi

for matcher in ${matchers}; do
    if [ "${ENABLE_PROBLEM_MATCHERS}" = "true" ]; then
        path="${GITHUB_ACTION_PATH}/matchers/${matcher}.json"
        echo "Adding problem matcher ${path}"
        echo "::add-matcher::${path}"
    else
        echo "Removing problem matcher ${matcher}"
        echo "::remove-matcher owner=${matcher}::"
    fi
done
