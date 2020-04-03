#!/bin/bash

# Create new image from scratch

# First, build: docker build -t gretl .
PROG="gretl"
VERSION="2020b"

# Create a NEW image
docker build --tag ${PROG}:${VERSION} . # run the Dockerfile in your current folder