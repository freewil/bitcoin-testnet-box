# bitcoin-testnet-box

This is a private, difficulty 1 testnet in a box. 

You must have bitcoind installed on your system and in the path unless running this within
a [Docker](https://www.docker.io) container.

## Starting the testnet-box

This will start-up two nodes using the two datadirs `1` and `2`. They
will only connect to each other in order to remain an isolated private testnet.
You need two because otherwise the node won't generate blocks.

Node `1` will listen on port `19000`, allowing node `2` to connect to it.

Node `1` will listen on port `19001` and node `2` will listen on port `19011` 
for the JSON-RPC server.


```
$ make start
```

## Check the status of the nodes

```
$ make getinfo
bitcoind -datadir=1  getinfo
{
    "version" : 80000,
    "protocolversion" : 70001,
    "walletversion" : 60000,
    "balance" : 0.00000000,
    "blocks" : 55922,
    "connections" : 1,
    "proxy" : "",
    "difficulty" : 1.00000000,
    "testnet" : true,
    "keypoololdest" : 1362643839,
    "keypoolsize" : 101,
    "paytxfee" : 0.00000000,
    "errors" : ""
}
bitcoind -datadir=2  getinfo
{
    "version" : 80000,
    "protocolversion" : 70001,
    "walletversion" : 60000,
    "balance" : 0.00000000,
    "blocks" : 55922,
    "connections" : 1,
    "proxy" : "",
    "difficulty" : 1.00000000,
    "testnet" : true,
    "keypoololdest" : 1362643615,
    "keypoolsize" : 101,
    "paytxfee" : 0.00000000,
    "errors" : ""
}
```

## Generating blocks

To start generating blocks:

```
$ make generate
```
  
## Stopping the testnet-box
  
```
$ make stop
```
  
To clean up any files created while running the testnet and restore to the 
original state:

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

This will allow you to connect via JSON-RPC from outside the Docker container via port 49155 (which is mapped to 19001) to the first node. It also adds a convenient name to the container so if you exit it you and resume it by name.

When you `run` a docker container it creates a new one from scratch. If you exit the container and wish to restart it you can either

* `docker start bitcoind` which will restart it in the background, or
* `docker attach bitcoind` which will start it and drop you into the terminal (as per the `-i` flag in the run command above).

Note that you can use `docker ps -a` to show all containers including the ones you have exited.

