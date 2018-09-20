#!/usr/bin/env bash

# Script to deploy the app
deploy(){
# From the remote host-machine, run the following cmd
    docker pull s34n/eureka-img
    docker run --name='eureka' -d -it -p 8001:8001 s34n/eureka-img && docker logs eureka -f
}

# Tag-And-Push Script to tag & push the app
tagAndPush(){
    docker tag eureka-img:latest s34n/eureka-img:latest
    docker push s34n/eureka-img:latest
}

# Rebuild-Script to clean & build the app using the Dockerfile script
rebuild(){
    gradle clean
    gradle build
    docker build -f Dockerfile -t eureka-img .
    tagAndPush
}

# Let's get rid of the pre-existing docker images on the machine.
if [[ ! -z "$(docker container ps | grep eureka)" ]]; then
    echo "Eureka-Service Docker Container Found"
    docker stop eureka && docker rm eureka && docker rmi eureka-img
    rebuild
else
    echo "Eureka-Service Docker Container NOT Found"
    rebuild
fi

