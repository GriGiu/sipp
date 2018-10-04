FROM debian:stretch-slim

MAINTAINER Gri Giu <grigiu@gmail.com>

ENV SIPP_VERSION 3.5.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl automake ncurses-dev libssl-dev libsctp-dev libpcap-dev wget openssl && \
    rm -rf /var/lib/apt/lists/*

#RUN mkdir /build /data && \
#    cd /build && \
#    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1 && \
#    ./build.sh --with-openssl --with-pcap --with-rtpstream --with-sctp && \
#    mv sipp /usr/bin

RUN mkdir /build /data && \
    cd /build && \
    wget -O  https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz && \
    tar -xvzf sipp_${SIPP_VERSION}.tar.gz && \
    cd sipp  && \
    ./configure  --with-sctp --with-pcap --with-openssl && \
    make


WORKDIR /
RUN mkdir /scens
RUN mkdir /logs

VOLUME /scens
VOLUME /logs

EXPOSE 5060-5070

ENTRYPOINT [ "sipp" ]
