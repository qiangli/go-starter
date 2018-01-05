#!/usr/bin/env bash

#set -x

echo "#### Vendoring..."
#
source setenv.sh

#
which godep; if [ $? -ne 0 ]; then
    echo "godep not installed, getting it..."
    go get github.com/tools/godep
fi

echo

#
go get -d github.com/qiangli/go2/web
go get -d github.com/qiangli/go2/web/gorilla
go get -d github.com/qiangli/go2/web/jsonrest
go get -d github.com/ant0ine/go-json-rest/rest
go get -d github.com/qiangli/go2/web/restful
#
go get -d golang.org/x/sys/unix

godep save; if [ $? -ne 0 ]; then
    echo "godev failed"
    exit 1
fi

echo "#### Vendoring done"

exit 0
##
