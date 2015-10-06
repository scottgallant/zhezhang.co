+++
date = "2015-10-06"
title = "Hugo, Docker and DaoCloud"
slug = "hugo-docker-and-daocloud"

+++

Recently, I've been playing with [Docker](https://www.docker.com/) and [DaoCloud](https://www.daocloud.io/) and I found both of them amazing. So I decided to see what they could do on dockerizing my [Hugo](http://gohugo.io/) site and integrate it with DaoCloud's CI service. The main workflow is like this: I setup a repo of my dockerized site on Github, and everytime I commit the changes to the repo with a new tag, it will automatically trigger DaoCloud to build and update this very site.

### Dockerize the existing Hugo site

Firstly, I built a Docker image by writing a Dockerfile that contains all the commands that I needed to create a fully functional image. (The advantage of writing a Dockerfile is that you can version-control all the dependencies and people will be able to audit all the commands you used.) Once the image is done, you can run it on any host where Docker is running regardless if it's a local host or a remote host.

Below is an example of a Dockerfile:

```
FROM alpine:3.2
MAINTAINER Zhe Zhang (https://github.com/zhe)

RUN apk add --update wget && rm -rf /var/cache/apk/*

ENV HUGO_VERSION 0.14
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64

WORKDIR /tmp

RUN wget --no-check-certificate https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz \
    && tar -xzf ${HUGO_BINARY}.tar.gz and \
    && mv /tmp/${HUGO_BINARY}/${HUGO_BINARY} /usr/local/bin/hugo \
    && rm -rf /tmp/*

RUN mkdir -p /srv/hugo
COPY . /srv/hugo

WORKDIR /srv/hugo
EXPOSE 80
CMD ["hugo", "server", "--bind=0.0.0.0", "--baseUrl=http://zhezhang.co/", "--port=80", "--appendPort=false"]
```

### Register an account at DaoCloud

Next, I registered an account at DaoCloud to setup the connection between DaoCloud and my host server where I was going to serve my site. (This action will allow DaoCloud to communicate with your server by its automated continuous-integration service.) Currently, DaoCloud supports QCloud, Aliyun, UCloud and your own host which has at least Ubuntu 12.04 or Centos 7.

### Setup the server at DigitalOcean

Also, I obtained the basic cloud hosting plan at [DigitalOcean](https://www.digitalocean.com/?refcode=f3851a9bdb88) which costs $5/mo. To set it up, I created a Droplet with Docker 1.8.2 on Ubuntu 14.04, so that I will get the basic environment to run Docker. Then, I installed a tool called Host Monitor Tool from DaoCloud onto my new Droplet. That tool basically is a service container running on the host in order to communicate with DaoCloud. At the moment, my host is already connected and running properly inside DaoCloud's dashboard. 

### Allow DaoCloud to access Github repos

Next thing I did was I authorised DaoCloud to access my Github repos. (Currently, DaoCloud supports connecting with Github, Bitbucket, Coding and GitCafe.) When allowing DaoCloud to connect to Github as a third-party application, DaoCloud will also require the access to your private repositories and email address. 

### Building

After Docker was installed on my server and my DaoCloud account was connected to my Github repos, from DaoCloud's dashboard, I created a new project (build-flow) using my site repo from Github. (DaoCloud will initially build a Docker image from the latest commit.) Then I deployed this image to my own host which is a droplet on DigitalOcean. This process wrapped my Hugo site inside a container and served it on my server already. This said container exposes its port 80 to the host, and Docker maps this port 80 to a random port on the host. In my case, a local Docker host port 36789 is mapped to the container's port 80. 

### Configure Nginx on the server

For now, I can visit my site using my droplet's IP address plus :36789. But that's not done yet. Since my domain name was already pointed to my droplet, the last thing to do is to write a Nginx server block configuration to direct the visits to the right container after installing Nginx to my new Droplet.

The cycle is done. Next time I update my Hugo site, I will only need to commit the changes to Github with a new tag, and DaoCloud will automatically pull the new codes, build new image and update my site.

It was really fun.