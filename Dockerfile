FROM alpine:3.20 AS build

RUN apk add --no-cache \
    binutils \
    cmake \
    g++ \
    gcc \
    git \
    gsl-dev \
    gsl-static \
    help2man \
    libpcap-dev \
    libpcap \
    make \
    ncurses-dev \
    ncurses-static \
    ninja \
    openssl-dev \
    lksctp-tools-dev

WORKDIR /sipp

RUN git clone https://github.com/SIPp/sipp.git . && \
    git submodule update --init && \
    git config --global --add safe.directory /sipp

RUN cmake . \
    -DUSE_PCAP=ON \
    -DUSE_SSL=ON \
    -DUSE_SCTP=ON \
    -DUSE_GSL=ON \
    -DBUILD_STATIC=ON \
    -G Ninja && \
    ninja

FROM alpine:3.20

RUN apk add --no-cache \
    libstdc++ \
    ncurses-libs \
    libpcap

COPY --from=build /sipp/sipp /usr/local/bin/sipp

ENTRYPOINT ["sipp"]
