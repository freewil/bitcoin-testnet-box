BITCOIND=bitcoind
BITCOIND1=$(BITCOIND) -datadir=1
BITCOIND2=$(BITCOIND) -datadir=2

start:
	$(BITCOIND1) -daemon
	$(BITCOIND2) -daemon
	
generate-true:
	$(BITCOIND1) setgenerate true
	
generate-false:
	$(BITCOIND1) setgenerate false
	
getinfo:
	$(BITCOIND1) getinfo
	$(BITCOIND2) getinfo
	
stop:
	$(BITCOIND1) stop
	$(BITCOIND2) stop

clean:
	rm -rf 1/testnet
	rm -rf 2/testnet