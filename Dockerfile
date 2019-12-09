FROM ubuntu:16.04

ARG quiet='-q -y -o Dpkg::Use-Pty=0'

#Install node.js
RUN apt-get update $quiet &&\
    apt-get install $quiet curl &&\
    curl -sL https://deb.nodesource.com/setup_10.x |  bash - &&\
    apt-get update $quiet  &&\
    apt-get install $quiet nodejs git

ARG BRANCH

#Install cheerio & webpack dependencies
RUN git clone https://github.com/cheeriojs/cheerio.git &&\
    cd cheerio &&\
    git checkout ${BRANCH} &&\
    npm install &&\
    npm install --save-dev \
      @babel/core \
      @babel/plugin-proposal-class-properties \
      @babel/plugin-transform-regenerator \
      @babel/plugin-transform-runtime \
      @babel/preset-env \
      @babel/plugin-transform-spread \
      @babel/plugin-transform-destructuring \
      babel-loader \
      babel-runtime \
      string-replace-loader \
      webpack \
      webpack-cli \
      @babel/runtime \
      typedarray

#Copy build files
COPY ./cheerio /cheerio


ARG MODE

RUN cd cheerio && ./node_modules/.bin/webpack
