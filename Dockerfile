# bitcoin-testnet-box docker image
#
# This image uses an "easy-mining" branch of bitcoind to make new blocks occur 
# more frequently while mining with `make generate-true`
#

FROM ubuntu:12.04
MAINTAINER Sean Lavine <sean@vaurum.com>

# basic dependencies to build headless bitcoind
# https://github.com/freewil/bitcoin/blob/easy-mining/doc/build-unix.md
RUN apt-get update
RUN apt-get install --yes build-essential libssl-dev libboost-all-dev

# install db4.8 provided via the bitcoin PPA
RUN apt-get install --yes python-software-properties
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install --yes db4.8

# install git to clone bitcoin's source
RUN apt-get install --yes git

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# clone bitcoin easy-mining branch and build it without UPnP support
RUN git clone https://github.com/freewil/bitcoin.git
RUN cd bitcoin && git checkout easy-mining
RUN cd bitcoin/src && make -f makefile.unix USE_UPNP=

# install bitcoind
RUN cp bitcoin/src/bitcoind /usr/local/bin/bitcoind

# copy the testnet-box files into the image
ADD . /home/tester/bitcoin-testnet-box

# make tester user own the bitcoin-testnet-box
RUN chown -R tester:tester /home/tester/bitcoin-testnet-box

# use the tester user when running the image
USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/bitcoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011
CMD ["/bin/bash"]
