# Using Docker

I host a Gretl Docker container based on Ubuntu here:
https://hub.docker.com/r/atecon/gretl/


# Some basic commands

## Build and run

### Get an overview
See how much space current images need:
```
docker system df
```

### List existing images
```
docker image ls
```
or
```
docker images
```

### List running containers
```
docker ps -all
```
or list all images ever run on your computer
```
docker ps --all
```

### Pull an image
```
docker pull ubuntu:20.10
```

### Start a container
Run the container in interactive mode:
```
docker run -it --name=<NAME_YOUR_CONTAINER_INSTANCE> ubuntu:20.10 /bin/bash
```

Options are: \
- ```-i``` tells docker to attach stdin to the container \
- ```-t``` tells docker to give us a pseudo-terminal \
- ```/bin/bash``` will run a terminal process in your container \
- ```--name``` specifies a name with which you can refer to your container in subsequent commands, e.g. ```docker rm --force <NAME_YOUR_CONTAINER_INSTANCE>``` \
- ```-rm``` automatically removes the container when it exits

If the image ```ubuntu:20.10``` is not available on your system, this command will load it from docker-hub and start the container locally.


### Do something in the container
Via the ```exec``` command you can, for instance, start the bash:
```
docker exec -ti CONTAINER_ID bash
```

### Stop a container
In another shell window, you can stop the container by
```
docker stop ubuntu:20.10
```

To stop all running containers do:
```
docker stop $(docker ps –a –q)
```

### Remove an image
```
docker image rm [-f] <IMAGE ID>
```
or
```
docker image rm [-f] <REPOSITORY:TAG>
```

For removing **all** images:
```
docker rmi $(docker images -q) -f
```

#### List size of active containers
```
docker ps --size
```

### Prune container
From time to time it can happen that already deleted images are still somewhere located. Run the following commands to clean up
```
docker image prune && docker container prune
```


### Build an image
cd into a directory with a Dockerfile, and run
```
docker build --tag <REPOSITORY:TAG> .
```
The ```.``` the the build context to the current directory.

To be more concrete, run the following command in the current directory
```
docker build --tag ubuntu-gretl:2020f
```
to create a new image with the name "ubuntu-gretl" and tag 2020f.


## Share images

### Push an image to Docker repository
A Docker registry is where Docker images live. One of the popular Docker registries is Docker Hub. You’ll need an account to push Docker images to Docker Hub, and you can create one here.

First you login to your account:
```
docker login
```

Retag the image with a version number:
```
docker tag <USERNAME>/<REPO_NAME> <DOCKER_USERNAME>/<REPO_NAME>:<VERSION_TAG>
```
and then push
```
docker push <DOCKER_USERNAME>/<REPO_NAME>:<VERSION_TAG>
```

You can list Docker containers:
```
docker ps
```
And you can inspect a container:
```
docker inspect <container-id>
```

You can view Docker logs in a Docker container:
```
docker logs <container-id>
```
And you can stop a running container:
```
docker stop <container-id>
```

## Get the Gretl image, modify it and publish

### Example
Get the gretl image and start the bash
```
docker run -it atecon/gretl:2020f /bin/bash
```

Do some things, for instance install a new package or update stuff. Once you are finished, commit the changes to the container as a new image


Exit the container by
```
exit

```
or read the container ID, and stop the container:
```
docker ps -a
docker stop <container-id>
```

### Tag the new image
Re-tagging an existing local image
```
docker tag: existing-image> <hub-user>/<repo-name>[:<tag>]
docker tag edbb1a24100b atecon/gretl:2020f
```

### Commit
[Create a new image from a container’s changes](https://docs.docker.com/engine/reference/commandline/commit/):
```
docker commit <existing-container> <hub-user>/<repo-name>[:<tag>]
```
(read out the container ID via ```docker ps -a```)

You may also add an author and a commit message (good habit!):
```
docker commit -a "Author Name" -m "Commit message" container-id/container-name new-image-name
```

Here is a concrete example:
```
docker commit -a "atecon" -m "use ubuntu:20.10 + freshly compiled gretl version 2020f (current dev); remove unnecessary libs after compilation" 0ba0c4336d74 atecon/gretl:2020f
```

Running ```docker images``` will show:
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
atecon/gretl        2020f               3c75ce0e4a0a        53 seconds ago      1.56GB
ubuntu-gretl        2020f               edbb1a24100b        14 minutes ago      1.56GB
ubuntu              20.10               671495eee4d8        2 weeks ago         79.5MB
```

### Test the new image
```
docker run -it atecon/gretl:2020f gretlcli --version
```

### Push the image to Docker-Hub
```
docker push <DOCKER_USERNAME>/<REPO_NAME>:<VERSION_TAG>
```
```
docker push atecon/gretl:2020f
```

# How-to update the gretl Docker image
The gretl image atecon/gretl:TAG is a lightweight image using Ubuntu 20.10. gretl was compiled which requires special libraries which were un-installed after compilation to reduce the volume of the image. Thus, we cannot simply pull the atecon/gretl:TAG image and re-run the ```./configure && make``` commands.

Thus, we recommend to run a complete ```docker build``` based on some ubuntu version of choice. Simply take the ```./Dockerfile``` of this repo as your starting point, and run the following steps:

```
docker login  # if you want to push the image somewhere
docker build --tag ubuntu-gretl:2020f .
docker images # check the outcome
docker ps -a  # check the outcome and note the container ID
docker tag IMAGE_ID atecon/gretl:2020f
docker tag IMAGE_ID USERNAME/REPO_NAME:TAG
docker commit -a "AUTHOR" -m "SOME_COMMIT_MESSAGE" CONTAINER_ID USERNAME/REPO_NAME:TAG
```

In my concrete case I ran:
```
docker login  # if you want to push the image somewhere
docker build --tag ubuntu-gretl:2020f .
docker images # check the outcome
docker ps -a  # check the outcome and note the container ID
docker tag edbb1a24100b atecon/gretl:2020f
docker commit -a "atecon" -m "use ubuntu:20.10 + freshly compiled gretl version 2020f (current dev); remove unnecessary libs after compilation" 0ba0c4336d74 atecon/gretl:2020f
docker run -it atecon/gretl:2020f gretlcli --version  # just a check
docker push atecon/gretl:2020f
```



# References
- https://gist.github.com/glamp/74188691c91d52770807 \
- https://phoenixnap.com/kb/how-to-commit-changes-to-docker-image \
- [RUN, CMD and ENTRYPOINT](https://goinbigdata.com/
docker-run-vs-cmd-vs-entrypoint/) \
- [ENTRYPOINT vs. CMD](https://phoenixnap.com/kb/docker-cmd-vs-entrypoint9) \
- https://docs.docker.com/docker-hub/repos/
- https://realpython.com/python-versions-docker/ \
- https://stackify.com/docker-build-a-beginners-guide-to-building-docker-images/ \
- https://www.linode.com/docs/applications/containers/create-tag-and-upload-your-own-docker-image/
