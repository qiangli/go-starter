#!/usr/bin/env bash

#set -x

#
function define() {
    IFS='\n' read -r -d '' ${1} || true;
}

function env_subst() {
    local template=$1
    local output=$2

    eval "echo \"$(cat $template)\"" | cat - > $output
}

#
# set and check environment/tool
#
if [ "x$WORKSPACE" = "x" ]; then
    #set to current project folder if .git is detected
    which git; if [ $? -eq 0 ]; then
        if [ -d ".git" ]; then
            export WORKSPACE=`pwd`
        fi
    fi
fi

if [ "x$WORKSPACE" = "x" ]; then
    echo "WORKSPACE not set"
    exit 1
fi

cd $WORKSPACE; if [ $? -ne 0 ]; then
    echo "$WORKSPACE does not exist"
    exit 1
fi

#
if [ "x$ENV" = "x" ]; then
    echo "default ENV to $USER"
    export ENV=$USER
fi

#
if [ "x$GOPATH" = "x" ]; then
    echo "GOPATH not set"
    exit 1
fi

which go; if [ $? -ne 0 ]; then
    echo "go not installed"
    exit 1
fi

# default log level to debug
if [ "x$log_level" = "x" ]; then
    export log_level=DEBUG
fi

#

export APP_EXE=`basename $WORKSPACE`
#
echo ""
echo "Go environment"
go env

echo ""
echo "WORKSPACE: $WORKSPACE"
echo "ENV(Predix deploy): $ENV"
echo ""
echo "Working directory: `pwd`"
echo "GOPATH: $GOPATH"
echo "GO: `go version`"
echo "APO_EXE: $APP_EXE"
echo ""
echo "LOG_LEVEL: $log_level"
echo ""
#