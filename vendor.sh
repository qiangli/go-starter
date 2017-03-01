#!/usr/bin/env bash

#set -x

echo "#### Vendoring..."
#
rm -rf ./vendor
rm -rf ./Godeps
#
source ./script/setenv.sh

#
which godep; if [ $? -ne 0 ]; then
    echo "godep not installed, getting it..."
    go get github.com/tools/godep
fi

echo

#
go get -d github.com/geaviation/goboot/web
go get -d github.com/geaviation/goboot/web/gorilla
go get -d github.com/geaviation/goboot/web/jsonrest
go get -d github.com/ant0ine/go-json-rest/rest
go get -d github.com/geaviation/goboot/web/restful

godep save; if [ $? -ne 0 ]; then
    echo "godev failed"
    exit 1
fi

echo "#### Vendoring done"

exit 0
##
