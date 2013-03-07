# bitcoin-testnet-box

This is a private, difficulty 1 testnet in a box.

The master branch is meant for bitcoind v0.8.0. 
Check the tags for other bitcoind versions.

You must have bitcoind installed on your system and in the path.

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
$ make generate-true
```
  
To stop generating blocks:

```
$ make generate-false
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
