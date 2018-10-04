FROM debian:stretch-slim

MAINTAINER Gri Giu <grigiu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive 
ENV SIPP_VERSION 3.5.1

RUN apt-get update && apt-get install -y \
    build-essential \
    libncurses5-dev \
    libssl-dev \
    libsctp-dev \
    libpcap-dev \
    curl \
    vim 

#RUN mkdir /build /data && \
#    cd /build && \
#    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1 && \
#    ./build.sh --with-openssl --with-pcap --with-rtpstream --with-sctp && \
#    mv sipp /usr/bin

RUN mkdir /build /data && \
    cd /build && \
    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1
    
#RUN  cd  /build && ls -l && ./configure --with-pcap --with-sctp --with-openssl --with-rtpstream && make SHARED=0 CC='gcc -static' install
RUN  cd  /build && ls -l && ./configure --with-pcap --with-sctp  --with-rtpstream && make SHARED=0 CC='gcc -static' install

RUN mv /build/sipp /usr/bin


WORKDIR /
RUN mkdir /scens
RUN mkdir /logs

VOLUME /scens
VOLUME /logs

EXPOSE 5060-5070

ENTRYPOINT [ "sipp" ]
