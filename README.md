#

goboot-starter is a sample micro service app built upon goboot core packages written in the Go language.
You should be able to install and run this starter app locally or deploy to GE Predix platform as is.

Preparation:

You should have git and go installed on your machine before you start. You will also need cf installed
and have signed up with Predix (free) if you plan to deploy to Predix Cloud Platform.

To verify, open a terminal and run the following commands:

#go version
go version go1.7.5 darwin/amd64

#git --version
git version 2.10.0

#cf version
cf version 6.21.1+6fd3c9f-2016-08-10

If you see console output similar to the above, you are ready to build and deploy.

If you need to install the tools, please follow the flowing links:

go: https://golang.org/dl/ (choose stable version 1.7.5 only, there are some issues with 1.8.x)
git: https://git-scm.com/
cf: https://github.com/cloudfoundry/cli/releases


1. Build

If you are new to Go and want to learn, you may start here:

https://golang.org/doc/code.html

https://golang.org/


To run goboot-starter locally after you have installed Go:


git clone https://github.com/geaviation/goboot-starter.git [my_project]

cd [my_project]

where [my_project] is your prefered directory name (as well as your app name), it will default to goboot-starter if not specified.

To start the  app:

sh run.sh

which will execute vendor.sh, build.sh, and start up a simple server.


Open a browser and enter http://localhost:8080, you should see something similar to the following:

{"server":"basic","name":"","version":"","build":"","timestamp":1487367204214}


2. Deploy

To deploy to GE Predix/Cloud Foundry:


Sign up for a free Predix account at: https://www.predix.io/registration/

cf login -a [predix_endpoint] -u [email] -p [password]

You should have got your password after signing up, to find your predix_endpoint, follow the instructions at:
https://www.predix.io/docs/?b=#hOTKiBl-Uva9INX3

For Predix US-West: https://api.system.aws-usw02-pr.ice.predix.io

To deploy to Predix:

sh deploy.sh


You should see APP_URL at the end of the console message if successful.


Congratulations! You have built and run the starter microservice locally and deployed the app to GE Predix platform.



