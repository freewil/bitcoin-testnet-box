# bitcoin-testnet-box docker image

FROM ubuntu:22.04
LABEL maintainer="Sean Lavine <lavis88@gmail.com>"

# install make
RUN apt-get update && \
	apt-get install --yes make wget nginx supervisor

# use btc as folder
WORKDIR /btc

ENV BITCOIN_CORE_VERSION "0.21.0"

# download and install bitcoin binaries
RUN mkdir tmp \
	&& cd tmp \
	&& wget "https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_CORE_VERSION}/bitcoin-${BITCOIN_CORE_VERSION}-x86_64-linux-gnu.tar.gz" \
	&& tar xzf "bitcoin-${BITCOIN_CORE_VERSION}-x86_64-linux-gnu.tar.gz" \
	&& cd "bitcoin-${BITCOIN_CORE_VERSION}/bin" \
	&& install --mode 755 --target-directory /usr/local/bin *

# clean up
RUN rm -r tmp

# copy the testnet-box files into the image
ADD . /btc/bitcoin-testnet-box

# color PS1
RUN mv /btc/bitcoin-testnet-box/.bashrc /btc/ && \
	cat /btc/.bashrc >> /etc/bash.bashrc

# run commands from inside the testnet-box directory
WORKDIR /btc/bitcoin-testnet-box

# copy nginx
COPY nginx.conf /etc/nginx/sites-enabled/default

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011 8080
CMD supervisord -c supervisord.conf