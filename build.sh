#!/usr/bin/env bash

#set -x

#
if [ "x$WORKSPACE" = "x" ]; then
    echo "WORKSPACE not set"
    exit 1
fi

cd $WORKSPACE; if [ $? -ne 0 ]; then
    echo "$WORKSPACE does not exist, exiting..."
    exit 1
fi

which go; if [ $? -ne 0 ]; then
    echo "GO not installed, exiting..."
    exit 1
fi

#
go version
pwd

#setenv
if [ -f ./script/setenv.sh ]; then
   echo "Sourcing ./script/setenv.sh."
   source ./script/setenv.sh
fi

printenv

#
if [ -f ./script/vendor.sh ]; then
    chmod +x ./script/vendor.sh
    ./script/vendor.sh; if [ $? -ne 0 ]; then
        echo "Vendoring failed, exiting..."
        exit 1
    fi
fi
#

function build_module() {
    echo "##### Building ..."

    echo "## Cleaning ..."
    go clean -x

    echo "## Building ..."
    go build -x

    echo "## Testing ..."
    go test -x

    echo "## Installing ..."
    go install -x

    if [ $? -ne 0 ]; then
        echo "#### Build failed."
        return 1
    else
        echo "#### Build successful."
        return 0
    fi
}

build_module; if [ $? -ne 0 ]; then
    exit 1
fi

echo "Done"

exit 0
##

