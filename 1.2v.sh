#!/usr/bin/env bash

set -xueo pipefail

FILE_URLS=${1:-}
if [[ -z "${FILE_URLS}" ]]; then
  echo "File with URLs list do not defined."
  exit 1
fi

function checkUrls() {
  local URLS=$1
  for URL in $(cat $URLS); do
    STATUS=`curl -LI "${URL}" -o /dev/null -w '%{http_code}' -s`
    if [[ "${STATUS}" == "500" ]] || [[ "${STATUS}" == "400" ]]; then
      echo "URL ${URL} unavailable!"
      exit 1
    else
      echo "URL ${URL} available."
    fi
  done
}

checkUrls "${FILE_URLS}"