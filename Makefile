BITCOIND=bitcoind
BITCOINGUI=bitcoin-qt
BITCOINCLI=bitcoin-cli
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
	$(BITCOINCLI) $(B1) setgenerate true 101

getinfo:
	$(BITCOINCLI) $(B1) getinfo
	$(BITCOINCLI) $(B2) getinfo

stop:
	$(BITCOIND) $(B1) stop
	$(BITCOIND) $(B2) stop

clean:
	rm -rf 1/regtest
	rm -rf 2/regtest
