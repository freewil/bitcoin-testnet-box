BITCOIND=bitcoind
BITCOINGUI=bitcoin-qt
B1_FLAGS=
B2_FLAGS=
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)

start:
  $(BITCOIND) $(B1) -daemon
  $(BITCOIND) $(B2) -daemon

start-gui:
  $(BITCOINGUI) $(B1) &
  $(BITCOINGUI) $(B2) &

generate:
  $(BITCOIND) $(B1) -regtest

getinfo:
  $(BITCOIND) $(B1) getinfo
  $(BITCOIND) $(B2) getinfo

stop:
  $(BITCOIND) $(B1) stop
  $(BITCOIND) $(B2) stop

clean:
  git clean -fd 1/testnet3
  git clean -fd 2/testnet3
  git checkout -- 1/testnet3
  git checkout -- 2/testnet3
