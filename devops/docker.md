# Docker

```
if i needed a specific version sans an app, i would just do docker run -it python:3.10 /bin/bash and then you're in your container w/ whatever version of python you specified w/ the tag


cool!
does `docker run -it <docker-image-here>`` work for other stuff? 
like if i wanted to use the latest ubuntu or something?

(optionally specifying a volume to mount some code from my machine into the container, say if i wanted to install my local version of the package docker run -v ${PWD}/:/app -it python:3.10 /bin/bash )
yep!

or postgres

by default run will do the configured command but you can also tell it to do arbitrary commands like docker run [ options ] image:tag [ some arbitrary command ]

i use docker run postgres pg_dump / pg_restore a lot and then /bin/bash will just drop you into a bash shell so you can cruise around in your container and do whatever
```

filling in knowledge gaps about docker

## docker vs docker-compose
docker builds an image, which is specified by Dockerfile. docker can then run a container based on the image it build. 

docker-compose can mangage multiple running containers — the services that interact with each other. so docker-compose needs some docker images to run as containers.


## docker-compose
declares an application and its dependent services. nice way to create the app's environment + connect it to a database. you can connect ports across the "network" (?) (i think docker-compose creates a network for communicating with the different services?)

there are several versions of it. use v2 because it's got some good health checks.


## Container life cycle
[from the datamade docs](https://github.com/datamade/how-to/blob/master/docker/local-development.md#1-dockerfile)

### images
By definition, docker-compose up "builds, (re)creates, starts, and attaches to containers for a service." More precisely, it builds any images that it can't find on the host, then proceeds with the rest.

the application image is built the first time you run docker-compose up. 

if you make any changes to your dockerfile or development environment (like adding something to the requirements.txt), you must rebuild your image using docker-compose up --build

### containers
`docker-compose up` creates and starts containers for all the services defined in `docker-compose.yml`. if you change your service definition, the Compose will automatically recreate your applicaiton container (this is the opposite of an image)



### examples
build the images:
```bash
docker-compose build
```

it might look like this:
```bash
Building app
Step 1/8 : FROM python:3.5
3.5: Pulling from library/python
57df1a1f1ad8: Already exists
71e126169501: Already exists
1af28a55c3f3: Already exists
03f1c9932170: Already exists
65b3db15f518: Already exists
850581be87f3: Already exists
1e37775630ae: Already exists
7e054ca5fcba: Already exists
92a0fe226896: Already exists
Digest: sha256:42a37d6b8c00b186bdfb2b620fa8023eb775b3eb3a768fd3c2e421964eee9665
Status: Downloaded newer image for python:3.5
 ---> 3687eb5ea744
Step 2/8 : LABEL maintainer "me <me@me.com>"
 ---> Running in c709004e5404
Removing intermediate container c709004e5404
 ---> 0b737431fc13
Step 3/8 : RUN mkdir /app
 ---> Running in 53496cbe9060
Removing intermediate container 53496cbe9060
 ---> e1df11286f04
Step 4/8 : WORKDIR /app
 ---> Running in 11dea7397c20
Removing intermediate container 11dea7397c20
 ---> 07fb4c43e952
Step 5/8 : COPY ./requirements.txt /app/requirements.txt
 ---> b89807941a82
Step 6/8 : RUN pip install --no-cache-dir -r requirements.txt
 ---> Running in cc49893632a6
 ...
 ... // outputs the requirements install
 ...
 Removing intermediate container cc49893632a6
 ---> d7b6cf10ae5a
Step 7/8 : COPY . /app
 ---> dd3e3e3b0b1e
Step 8/8 : CMD exec python app.py
 ---> Running in 4cc0c8d2da17
Removing intermediate container 4cc0c8d2da17
 ---> d3abc34ccd75

Successfully built d3abc34ccd75
Successfully tagged my-app:latest
```

run:
```bash
docker-compose up
```

## etc
### variables
[See their documentation](https://docs.docker.com/compose/environment-variables/)

## questions
- i have three different places where i declare a command to run the app. which one does which? 

## resources
- [DataMade's guide to docker for local development](https://github.com/datamade/how-to/blob/master/docker/local-development.md)
