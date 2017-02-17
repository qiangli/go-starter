#!/usr/bin/env bash

#set -x
#
function define() {
    IFS='\n' read -r -d '' ${1} || true;
}

#
if [ "x$log_level" = "x" ]; then
    export log_level=DEBUG
fi

#