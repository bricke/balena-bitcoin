# 1. Base OS Image
FROM ubuntu:latest

LABEL maintainer.0="Matt Brichese (@bricke)"

# Adding bitcoin user
RUN useradd -r bitcoin
RUN mkdir -p /workspace /script
WORKDIR /workspace

# Installing dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git gosu \
	build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 \
	libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev \
	libevent-dev libboost-test-dev libzmq3-dev

# Clone bitcoin-core src
RUN git clone --depth 2 --branch v22.0 https://github.com/bitcoin/bitcoin.git

WORKDIR /workspace/bitcoin

# AUTOGEN + CONFIGURE
RUN ./autogen.sh && ./configure --without-bdb --without-gui --disable-wallet --disable-tests
RUN make -j 2 && make install


COPY bitcoin-init.sh /script/bitcoin-init.sh
ENTRYPOINT ["/script/bitcoin-init.sh"]
