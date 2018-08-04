BITCOIND=bitcoind
BITCOINGUI=bitcoin-qt
BITCOINCLI=bitcoin-cli
B1_FLAGS=
B2_FLAGS=
B3_FLAGS=
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)
B3=-datadir=3 $(B3_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start:
	$(BITCOIND) $(B1) -daemon
	$(BITCOIND) $(B2) -daemon
	$(BITCOIND) $(B3) -daemon

start-gui:
	$(BITCOINGUI) $(B1) &
	$(BITCOINGUI) $(B2) &
	$(BITCOINGUI) $(B3) &

generate:
	$(BITCOINCLI) $(B1) generate $(BLOCKS)

getinfo:
	$(BITCOINCLI) $(B1) -getinfo
	$(BITCOINCLI) $(B2) -getinfo
	$(BITCOINCLI) $(B3) -getinfo

sendfrom1:
	$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom3:
	$(BITCOINCLI) $(B3) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

address3:
	$(BITCOINCLI) $(B3) getnewaddress $(ACCOUNT)

stop:
	$(BITCOINCLI) $(B1) stop
	$(BITCOINCLI) $(B2) stop
	$(BITCOINCLI) $(B3) stop

clean:
	find 1/regtest/* -not -name 'server.*' -delete
	find 2/regtest/* -not -name 'server.*' -delete
	find 3/regtest/* -not -name 'server.*' -delete
