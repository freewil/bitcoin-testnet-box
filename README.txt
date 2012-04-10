This is a private, difficulty 1 testnet in a box.

Use it as follows:

  $ cd ~/testnet-box
  $ bitcoin -datadir=1 -daemon
  $ bitcoin -datadir=2 -daemon

This will start two nodes. You need two because otherwise the node won't
generate blocks. You now have a private testnet:

  $ bitcoin -datadir=1 getinfo
  {
    "version" : 32002,
    "balance" : 3650.00000000,
    "blocks" : 192,
    "connections" : 1,
    "proxy" : "",
    "generate" : false,
    "genproclimit" : -1,
    "difficulty" : 1.00000000,
    "hashespersec" : 0,
    "testnet" : true,
    "keypoololdest" : 1300079472,
    "paytxfee" : 0.00000000,
    "errors" : ""
  }

To start generating blocks, enable it via the command line:

  $ bitcoin -datadir=1 help
  $ bitcoin -datadir=1 setgenerate true

Like all testnet nodes, it is listening on port 18333.
