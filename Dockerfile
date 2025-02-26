FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    build-base \
    autoconf \
    automake \
    libtool \
    linux-headers \
    ncurses-dev \
    openssl-dev \
    git \
    pcre-dev \
    cmake \
    bash

# Clone SIPp repository and build latest version
WORKDIR /usr/src
RUN git clone https://github.com/SIPp/sipp.git && \
    cd sipp && \
    ./build.sh --with-pcap --with-sctp --with-openssl && \
    mv sipp /usr/local/bin/ && \
    cd .. && rm -rf sipp

# Default command
ENTRYPOINT ["sipp"]

