#!/usr/bin/env bash

set -x
#
which cf; if [ $? -ne 0 ]; then
    echo "cf not installed, exiting..."
    exit 1
fi

#install zero downtime plugin if not present

cf plugins|grep blue-green-deploy; if [ $? -ne 0 ]; then
    echo "installing bgd..."
	cf install-plugin -r CF-Community "blue-green-deploy" -f; if [ $? -ne 0 ]; then
	    echo "failed to install bgd"
	    exit 1
	fi
else
    echo "plugin bgd found"
fi

#show all
cf list-plugin-repos
cf plugins

exit 0
##