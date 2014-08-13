# bitcoin-testnet-box

This is a private, difficulty 1 testnet in a box. 

You must have bitcoind installed on your system and in the path unless running this within
a [Docker](https://www.docker.io) container (see [below](#using-with-docker)).

## Starting the testnet-box

This will start-up two nodes using the two datadirs `1` and `2` in `-regtest` mode.

* Node `1` will listen on port `19000`, allowing node `2` to connect to it.
* In addition, node `1` will listen on port `19001` and node `2` will listen on port `19011` for the JSON-RPC server.

```
$ make start
```

## Check the status of the nodes

```
$ make getinfo
bitcoind -datadir=1  getinfo
{
  "version" : 90201,
  "protocolversion" : 70002,
  "walletversion" : 60000,
  "balance" : 3950.00000000,
  "blocks" : 56101,
  "timeoffset" : 0,
  "connections" : 1,
  "proxy" : "",
  "difficulty" : 1.00000000,
  "testnet" : false,
  "keypoololdest" : 1362643840,
  "keypoolsize" : 109,
  "paytxfee" : 0.00000000,
  "relayfee" : 0.00001000,
  "errors" : ""
}
bitcoind -datadir=2  getinfo
{
  "version" : 90201,
  "protocolversion" : 70002,
  "walletversion" : 60000,
  "balance" : 0.00000000,
  "blocks" : 56101,
  "timeoffset" : 0,
  "connections" : 1,
  "proxy" : "",
  "difficulty" : 1.00000000,
  "testnet" : false,
  "keypoololdest" : 1362643615,
  "keypoolsize" : 101,
  "paytxfee" : 0.00000000,
  "relayfee" : 0.00001000,
  "errors" : ""
}
```

## Generating blocks

> Bitcoin Core’s regression test mode (regtest mode) lets you instantly create a brand-new 
> private block chain with the same basic rules as testnet—but one major difference: 
> you choose when to create new blocks, so you have complete control over the environment.

To start generating blocks:

```
$ make generate
```

This will tell `bitcoin-cli` to immediate generate 101 blocks.

> Generate 101 blocks using a special version of the setgenerate RPC which is only available in
> regtest mode. This takes about 30 seconds on a generic PC. Because this is a new block chain using
> Bitcoin’s default rules, the first 210,000 blocks pay a block reward of 50 bitcoins. However, a 
> block must have 100 confirmations before that reward can be spent, so we generate 101 blocks to 
> get access to the coinbase transaction from block #1.

See [developer-examples#regtest-mode](https://bitcoin.org/en/developer-examples#regtest-mode) for more info.

## Stopping the testnet-box
  
```
$ make stop
```
  
To restore to the original state:

```
$ make clean
```

## Using with docker
This testnet-box can be used with [docker](https://www.docker.io/) to run it in
an isolated container.

### Building docker image

Pull the image

  * `docker pull freewil/bitcoin-testnet-box`, or
  
build it yourself from this directory

  * `docker build -t bitcoin-testnet-box .`

### Running the docker container
The docker image will run two bitcoin nodes in the background and is meant to be
attached to allow you to type in commands. The image also exposes
the two JSON-RPC ports from the nodes if you want to be able to access them
from outside the container.

* `$ docker run -ti -P -p 49155:19001 --name bitcoind freewil/bitcoin-testnet-box` to pull from the main docker repo, or simply
* `$ docker run -ti -P -p 49155:19001 --name bitcoind bitcoin-testnet-box` if you just built it yourself from this directory, as per the above.

This will allow you to connect via JSON-RPC from outside the Docker container via port 49155 (which is mapped to 19001) to the first node. It also adds a convenient name to the container so if you exit it you can resume it by name.

When you `run` a docker container it creates a new one from scratch. If you exit the container and wish to resume it you can either

* `docker start bitcoind` which will restart it in the background, or
* `docker attach bitcoind` which will start it and drop you into the terminal (as per the `-i` flag in the run command above).

Note that you can use `docker ps -a` to show all containers including the ones you have exited.

