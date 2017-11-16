# bitcoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:14.04
MAINTAINER Sean Lavine <lavis88@gmail.com>

# add bitcoind from the official PPA
RUN apt-get update
RUN apt-get install --yes software-properties-common supervisor
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN apt-get update

# install bitcoind (from PPA)
RUN apt-get install --yes bitcoind

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# copy the testnet-box files into the image
ADD . /home/tester/bitcoin-testnet-box

# make tester user own the bitcoin-testnet-box
RUN chown -R tester:tester /home/tester/bitcoin-testnet-box

RUN mkdir -p /var/log/supervisor

# run commands from inside the testnet-box directory
WORKDIR /home/tester/bitcoin-testnet-box

CMD ["/usr/bin/supervisord"]