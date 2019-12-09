#!/bin/bash

MODE=${MODE:-development}
BRANCH=${BRANCH:-master}

#Build
docker build -t cheerio-rhino . --build-arg MODE=${MODE} --build-arg BRANCH=${BRANCH}
docker rm  cheerio-rhino
docker create --name cheerio-rhino cheerio-rhino
docker cp cheerio-rhino:/cheerio/dist .

#Cleanup
docker rm  cheerio-rhino
docker rmi -f cheerio-rhino
