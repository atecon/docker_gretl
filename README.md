# Using Docker




# Some basic commands

### List existing images
```
docker image ls
```

### List running containers
```
docker ps
```
or
```
docker ps --all
```

### Start a container
Run the container in interactive mode:
```
docker run -it --name=<NAME_YOUR_CONTAINER_INSTANCE> ubuntu:20.10
```

If ubuntu:20.10 is not available on your system, this command will load the image from docker-hub and start the container locally!

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
