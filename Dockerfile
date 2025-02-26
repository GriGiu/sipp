FROM alpine:latest

# Maintainer
LABEL maintainer="grillo.giuseppe@gmail.com"

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
    bash \
    lksctp-tools-dev \
    tcpdump

# Clone SIPp repository and build latest version
WORKDIR /usr/src
RUN git clone https://github.com/SIPp/sipp.git && \
    cd sipp && \
    cmake . && \
    make && \
    make install && \
    cd .. && rm -rf sipp

# Default command
ENTRYPOINT ["sipp"]
