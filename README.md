# grigiu/adminer
sipp based debian strecht slim

[SIPp](http://http://sipp.sourceforge.net//)  is a free Open Source test tool / traffic generator for the SIP protocol. 
This is a Sipp [Docker](https://www.docker.com/) image.

This SIPp is compiled with :
* TLS support
* PCAP play support
* SCTP support


This images is based on Debian Stretch-slim

The recommended way to run this container looks like this:

```bash
$ docker run -d -p 5060:5060 -p 5070:5070 grigiu/sipp
```
or docker-compose
```bash
$ docker-compose up -d
```

  
This is a rather common setup following docker's conventions:

* `-d` will run a detached instance in the background
* `-p {OutsidePort}:5060` will bind the webserver to the given outside port
* `grigiu/sipp` the name of this docker image

## Usage

You can pass your SIPp arguments to the run command, example:

```
$ docker run -it grigiu/sipp -sn uas
```

If you want to use custom scenarios you can use the Docker VOLUME argument to include your local files inside your Docker image.  
The `-v /scenarios` is your local hosts working directory and `/scens` is the containers working directory.

```
$ docker run -it -v /scenarios:/scenarios -p 5060 grigiu/sipp -sf scen1.xml DEST_IP -s DEST_NUMBER
```


