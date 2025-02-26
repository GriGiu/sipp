# SIPp Docker Container

## Overview
This repository provides a Dockerized version of **SIPp**, a powerful SIP traffic generator and test tool. The container is based on **Alpine Linux**, ensuring a lightweight and efficient runtime.

## Maintainer
**Giuseppe Grillo** - grillo.giuseppe@gmail.com

## Getting Started

### Prerequisites
Ensure you have **Docker** installed on your system. If not, you can install it using:

```sh
# On Ubuntu
sudo apt update && sudo apt install -y docker.io

# On macOS (using Homebrew)
brew install --cask docker

# On Windows (Using Chocolatey)
choco install docker-desktop
```

### Building the SIPp Docker Image
To build the image locally, run:

```sh
git clone https://github.com/YOUR_GITHUB_USERNAME/sipp-docker.git
cd sipp-docker
docker build -t sipp .
```

### Running SIPp in a Docker Container

#### Basic Usage
To start a **SIPp** instance interactively, run:

```sh
docker run --rm -it sipp
```

#### Running a Local SIPp Scenario
To run a custom SIPp scenario (`custom.xml`):

```sh
docker run --rm -it -v $(pwd):/scenarios sipp -sf /scenarios/custom.xml 192.168.1.100
```

#### Running SIPp in UAC Mode (User Agent Client)
```sh
docker run --rm -it sipp 192.168.1.100 -s 1000 -sf /scenarios/uac.xml -r 10 -l 100
```

#### Running SIPp in UAS Mode (User Agent Server)
```sh
docker run --rm -it sipp -sn uas
```

### Using SCTP instead of UDP/TCP
To enable SCTP:
```sh
docker run --rm -it --network=host sipp -t sctp 192.168.1.100
```

### Capturing Traffic with PCAP
If you want to capture traffic during a test, use:
```sh
docker run --rm -it -v $(pwd):/pcap sipp -trace_msg -trace_err -trace_screen -message_file /pcap/sipp_messages.log 192.168.1.100
```

## Managing the SIPp Container

### Stopping a Running Container
If running in detached mode (`-d`), stop it with:
```sh
docker stop <container_id>
```

### Removing Unused Images
```sh
docker image prune -a
```

## Troubleshooting
If you encounter permission issues with mounting volumes, try running with `sudo`:
```sh
sudo docker run --rm -it -v $(pwd):/scenarios sipp -sf /scenarios/custom.xml 192.168.1.100
```

## References
- [SIPp Official GitHub](https://github.com/SIPp/sipp)
- [SIPp Documentation](https://sipp.readthedocs.io)
- [Docker Documentation](https://docs.docker.com)

