FROM debian:bookworm-slim

MAINTAINER Gri Giu <grigiu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SIPP_VERSION 3.7.3

RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    build-essential \
    libncurses5-dev \
    libssl-dev \
    libsctp-dev \
    libpcap-dev \
    curl \
    vim \
    pkg-config

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /build /data && \
    cd /build && \
    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1

RUN cd /build && ls -l && ./configure --with-pcap --with-sctp --with-openssl --with-rtpstream

WORKDIR /build
RUN make && make install

WORKDIR /sipp
RUN mkdir /scenarios
RUN mkdir /logs

VOLUME /scenarios
VOLUME /logs

EXPOSE 5060-5070

ENTRYPOINT ["sipp"]
