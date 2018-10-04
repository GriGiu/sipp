FROM debian:stretch-slim

MAINTAINER Gri Giu <grigiu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive 
ENV SIPP_VERSION 3.5.1

RUN apt-get update && apt-get install -y \
    build-essential \
    libncurses5-dev \
    libssl1.0-dev \
    libsctp-dev \
    libpcap-dev \
    curl \
    vim 

RUN mkdir /build /data && \
    cd /build && \
    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1
    
RUN  cd  /build && ls -l && ./configure --with-pcap --with-sctp --with-openssl --with-rtpstream 
WORKDIR /build
RUN  make install

WORKDIR /sipp
RUN mkdir /scens
RUN mkdir /logs

VOLUME /scenarios
VOLUME /logs

EXPOSE 5060-5070

ENTRYPOINT ["sipp"]
