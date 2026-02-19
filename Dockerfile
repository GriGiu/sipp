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
    make \
    ncurses-dev \
    ncurses-static \
    ninja \
    openssl-dev \
    lksctp-tools-dev

WORKDIR /sipp

RUN git clone https://github.com/SIPp/sipp.git . && \
    git config --global --add safe.directory /sipp && \
    cmake . -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_STATIC=1 \
        -DUSE_PCAP=1 \
        -DUSE_GSL=1 \
        -DUSE_SSL=1 \
        -DUSE_SCTP=1 && \
    ninja

FROM alpine:3.20

COPY --from=build /sipp/sipp /usr/local/bin/sipp

ENTRYPOINT ["sipp"]
