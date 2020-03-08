#!/bin/bash

# Readings:
# https://realpython.com/python-versions-docker/
# https://stackify.com/docker-build-a-beginners-guide-to-building-docker-images/
# https://www.linode.com/docs/applications/containers/create-tag-and-upload-your-own-docker-image/

# First, build: docker build -t gretl .
ARG PROG="gretl"
ARG VERSION="2020a"

docker build --tag $PROG:$VERSION . 

# Run in interactive mode
docker run -it --rm gretl:2020a
# or
docker run -it --rm gretl:2020a gretlcli


# mount src-folder as /app, starte container named "gretl" and execute gretl script
# docker run --rm -v /home/at/git/docker_gretl/src:/app gretl gretlcli -e -b ./app/print_data.inp

# Check existing container but a container must be running for showing the container ID!
docker ps -a

# Push Image to Docker Hub
docker login				# TODO: do I need the credentials every time??

docker commit --message "install gtk libs" \
--author "Artur Tarassow" eecf4db3a4b7 atecon/gretl:2020a

# This works and uploads to a new repo named 
#docker tag gretl:2020a gretl:2020
docker push atecon/gretl:2020a


## UPDATE container: https://blog.codeship.com/using-docker-commit-to-create-and-change-an-image/
1) Pull latest container 
2) docker run -it --rm gretl:2020a /bin/bash
3) apt update -qq && apt upgrade -y
4) cd git/gretl-git && git pull
5) ./configure --enable-openmp --with-mpi-lib=/usr/lib/x86_64-linux-gnu/openmpi/lib
6) make -j$(nproc) && make install && make clean && ldconfig
7) apt -y autoremove && rm -rf /var/lib/apt/lists/*
8) Open new terminal window, and determine CONTAINER_ID of running container: <docker ps -a>
9) docker commit --message "Some update" --author "Artur Tarassow" <NEW CONTAINER_ID> atecon/gretl:2020a
10) docker login
11) docker push atecon/gretl:2020a

cd git/gretl-git && git pull \
	&& ./configure --enable-openmp --with-mpi-lib=/usr/lib/x86_64-linux-gnu/openmpi/lib \
	&& make -j$(nproc) && make install && make clean && ldconfig \
	&& apt -y autoremove && rm -rf /var/lib/apt/lists/*
