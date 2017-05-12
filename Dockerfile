FROM ubuntu:latest

# add bitcoind from the official PPA
# install bitcoind (from PPA) and make
RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    add-apt-repository --yes ppa:bitcoin/bitcoin && \
    apt-get update && \
	apt-get install --yes bitcoind make

COPY . /root/btc-testbox
WORKDIR /root/btc-testbox

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011
CMD ["/bin/bash"]
