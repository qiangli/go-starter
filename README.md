#

goboot-starter is a sample micro service app built upon goboot core packages written in the Go language.
You should be able to install and run this starter app locally or deploy to GE Predix platform as is.


If you are new to Go, you may start here:

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


Deploy to GE Predix/Cloud Foundry:


Sign up for a free Predix account at: https://www.predix.io/registration/

cf login -a [predix_endpoint] -u [email] -p [password]

You should have got your password after signing up, to find your predix_endpoint, follow the instructions at:
https://www.predix.io/docs/?b=#hOTKiBl-Uva9INX3

For Predix US-West: https://api.system.aws-usw02-pr.ice.predix.io

To deploy to Predix:

sh deploy.sh


You should see APP_URL at the end of the console message if successful.


Congratulations! You have built and run the starter microservice locally and deployed the app to GE Predix platform.



