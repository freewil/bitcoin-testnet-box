BITCOIND=bitcoind
B1_FLAGS=
B2_FLAGS=
B1=$(BITCOIND) -datadir=1 $(B1_FLAGS)
B2=$(BITCOIND) -datadir=2 $(B2_FLAGS)

start:
	$(B1) -daemon
	$(B2) -daemon
	
generate-true:
	$(B1) setgenerate true
	
generate-false:
	$(B1) setgenerate false
	
getinfo:
	$(B1) getinfo
	$(B2) getinfo
	
stop:
	$(B1) stop
	$(B2) stop

clean:
	git clean -fd 1/testnet3
	git clean -fd 2/testnet3
	git checkout -- 1/testnet3
	git checkout -- 2/testnet3
