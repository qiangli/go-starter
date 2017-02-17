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

if [ "x$GOPATH" = "x" ]; then
    echo "GOPATH not set"
    exit 1
fi

which go; if [ $? -ne 0 ]; then
    echo "GO not installed"
    exit 1
fi

#
which godep; if [ $? -ne 0 ]; then
    echo "godep not installed, getting godep..."
    go get github.com/tools/godep
fi

echo
echo "Go enviroment..."

go env

#
echo "#### Vendoring..."

pwd

#rm -rf Godeps
#rm -rf vendor

go get -d github.com/geaviation/goboot/web
go get -d github.com/geaviation/goboot/web/gorilla
go get -d github.com/geaviation/goboot/web/jsonrest
go get -d github.com/ant0ine/go-json-rest/rest
go get -d github.com/geaviation/goboot/web/restful

godep save; if [ $? -ne 0 ]; then
    echo "Godev failed"
    exit 1
fi

echo "#### Vendoring Done"

exit 0
##
