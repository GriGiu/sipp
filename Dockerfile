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
    git submodule update --init && \
    git config --global --add safe.directory /sipp && \
    chmod +x build.sh && \
    ./build.sh --none && \
    ninja

FROM alpine:3.20

# Librerie runtime necessarie a sipp (C++ + ncurses)
RUN apk add --no-cache \
    libstdc++ \
    ncurses-libs

COPY --from=build /sipp/sipp /usr/local/bin/sipp

ENTRYPOINT ["sipp"]
