#!/bin/bash

# Create new image from scratch

# First, build: docker build -t gretl .
PROG="gretl"
VERSION="2020e"

# If you face network errors, this may be due to the docker DNS settings:
# https://medium.com/@faithfulanere/solved-docker-build-could-not-resolve-archive-ubuntu-com-apt-get-fails-to-install-anything-9ea4dfdcdcf2


# Create a NEW image
docker build --tag ${PROG}:${VERSION} . # run the Dockerfile in your current folder
