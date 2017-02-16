#!/usr/bin/env bash

#args:
# BUILD_NUMBER
# VERSION

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

#
if [ "x$ENV" = "x" ]; then
    echo "ENV not set, using USER: $USER"
    export ENV=$USER
fi

#
which cf; if [ $? -ne 0 ]; then
    echo "cf not installed, exiting..."
    exit 1
fi

export BUILD=$1_$(date "+%m%d%Y.%H%M.%S")
export VERSION=$2

if [ "x$VERSION" = "x" ]; then
    #default version to top commit hash
    which git; if [ $? -eq 0 ]; then
        export VERSION=$(git log -n 1 --pretty=format:%H)
    fi
fi

#
BUILD_DIR=$WORKSPACE/build

#check build
if [ -d $BUILD_DIR ]; then
   echo "dist found"
else
   echo "dist not found, creating..."
   mkdir -p $BUILD_DIR
fi

#
cd $WORKSPACE

#./script/cf-plugins.sh

#setenv
source ./script/setenv.sh

if [ -f ./setenv-${ENV}.sh ]; then
   echo "File ./setenv-${ENV}.sh exists."
   source ./setenv-${ENV}.sh
fi
#
printenv

#
echo "Deploying to $ENV ..."

#
function env_subst() {
    local template=$1
    local output=$2

    eval "echo \"$(cat $template)\"" | cat - > $output
}

function deploy() {
    echo "Pushing service..."

    env_subst manifest_env.yml $BUILD_DIR/manifest_${ENV}.yml

    cd $BUILD_DIR; if [ $? -ne 0 ]; then
        echo "build folder missing."
        return 1
    fi

    pwd
    cat manifest_${ENV}.yml

    #cf bgd aviation-ingestion-eot-${ENV} #--smoke-test <path to test script>

    cf push -f $BUILD_DIR/manifest_${ENV}.yml; if [ $? -ne 0 ]; then
        echo "Deploy failed."
        return 1
    else
        echo "Deploy succeeded"
        return 0
    fi
}

deploy; if [ $? -ne 0 ]; then
    exit 1
fi

echo "Done!"
##
