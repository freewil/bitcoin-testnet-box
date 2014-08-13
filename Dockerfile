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
RUN apt-get install -y build-essential libssl-dev libboost-all-dev

# install db4.8 provided via the bitcoin PPA
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y db4.8

# install git to be able to clean and reset the testnet from the repo
RUN apt-get install -y git

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# install bitcoind
RUN apt-get install -y bitcoind

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
