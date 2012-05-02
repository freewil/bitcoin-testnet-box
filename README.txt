This is a private, difficulty 1 testnet in a box.

Use it as follows:

  $ make start

This will start two nodes. You need two because otherwise the node won't
generate blocks. You now have a private testnet:

  $ make getinfo
  bitcoind -datadir=1  getinfo
  {
    "version" : 60006,
    "protocolversion" : 60000,
    "walletversion" : 60000,
    "balance" : 550.00000000,
    "blocks" : 130,
    "connections" : 1,
    "proxy" : "",
    "difficulty" : 0.12500000,
    "testnet" : true,
    "keypoololdest" : 1335827404,
    "keypoolsize" : 101,
    "paytxfee" : 0.00000000,
    "errors" : ""
  }
  bitcoind -datadir=2  getinfo
  {
    "version" : 60006,
    "protocolversion" : 60000,
    "walletversion" : 60000,
    "balance" : 0.00000000,
    "blocks" : 130,
    "connections" : 1,
    "proxy" : "",
    "difficulty" : 0.12500000,
    "testnet" : true,
    "keypoololdest" : 1335826149,
    "keypoolsize" : 101,
    "paytxfee" : 0.00000000,
    "errors" : ""
  }

To start generating blocks:

  $ make generate-true
  
To stop generating blocks:

  $ make generate-false
  
To stop the two nodes:
  
  $ make stop
  
To clean up any files created while running the testnet 
(and restore to the original state of 130 blocks)

  $ make clean

Like all testnet nodes, it is listening on port 18333.
