import os
import json
import ast
import csv

BITCOIND = 'bitcoind'
BITCOINGUI = 'bitcoin-qt'
BITCOINCLI = 'bitcoin-cli'
B1_FLAGS = ''
B2_FLAGS = ''
B3_FLAGS = ''
B1 = '-datadir=1 $(B1_FLAGS)'
B2 = '-datadir=2 $(B2_FLAGS)'
B3 = '-datadir=3 $(B3_FLAGS)'


class TestNet(object):

    def __init__(self):
        print('Initializing the TestNet')
        self.listblocks = []

    def get_block_height(self):
        return os.popen('bitcoin-cli -datadir=1 getblockcount').read()    

    def generate_transactions(self,from_node,to_node,amount,number_transactions=1):
        address = os.popen('bitcoin-cli -datadir='+str(to_node)+' getnewaddress').read().replace('\n',' ')
        for tx in range(number_transactions):
            os.popen(str('bitcoin-cli -datadir='+str(from_node)+' sendtoaddress '+str(address)+' '+str(amount)))       

    def generate_blocks(self,node=1,size=1):
        self.listblocks = self.listblocks + ast.literal_eval(os.popen('bitcoin-cli -datadir='+str(node)+' generate '+str(size)).read()) 
        blockheight = os.popen('bitcoin-cli -datadir=1 getblockcount').read()

    def invalidate_blocks(self,index=50):
        blockheight = os.popen('bitcoin-cli -datadir=1 getblockcount').read()
        print('Invalidating block ',self.listblocks[int(blockheight)-index])
        os.popen('bitcoin-cli -datadir=1 invalidateblock '+self.listblocks[int(blockheight)-index])
        self.listblocks = self.listblocks[:int(blockheight)-index]
        
        
    
class Tests(object):
    
    def __init__(self):
        self.tn=TestNet()	
    
    # The name simple_fork is bad. We need to organize test cases so that we can name/id them somehow
    def simple_fork(self):
        # Mine 60 blocks (20 each on nodes 1,2 and 3). They will have 1000 BTC each by 160th block
        # Mine 100 blocks usinf 4th Node. All mining henceforth will be done by 4th node
        # Next 100 blocks, Node 1 sends 5BTC to Node 2 (1 tx per block)
        # Dump all the data csv/somewhere (Balance and All Blocks)
        # Invalidate the last 100 blocks
        # Next 100 blocks, Node 1 sends 5BTC to Node 2 (1 tx per block)
        # Dump Data
        self.tn.generate_blocks(1,20)
        self.tn.generate_blocks(2,20)
        self.tn.generate_blocks(3,20)
        self.tn.generate_blocks(4,100)
        for tx in range(1,11):
            #Node1 sends 5 BTC to Node2
            self.tn.generate_transactions(1,2,5)
            self.tn.generate_blocks(4) 
        
        self.tn.invalidate_blocks(3)
        
        for tx in range(1,6):
            self.tn.generate_transactions(1,3,5)
            self.tn.generate_blocks(4)
        
    def prepare_balance_report(self):
        print('Preparing Balance Report. Check balances.csv')
        node1_balance = os.popen('bitcoin-cli -datadir=1 getbalance').read().replace('\n','')
        node2_balance = os.popen('bitcoin-cli -datadir=2 getbalance').read().replace('\n','')
        node3_balance = os.popen('bitcoin-cli -datadir=3 getbalance').read().replace('\n','')
        with open('balances.csv','w', newline='') as balances:
            balances_writer = csv.writer(balances, delimiter=' ',quotechar='|')
            balances_writer.writerow(['Node1',node1_balance]) 
            balances_writer.writerow(['Node2',str(node2_balance)]) 
            balances_writer.writerow(['Node3',str(node3_balance)])    

        
    def prepare_blockchain_report(self):
        print('Preparing Blockchain Report. Check blockchain.csv')
        with open('blockchain.csv','w', newline='') as blockchain:
            blockchain_writer = csv.writer(blockchain, delimiter=' ',quotechar='|')
            for block_hash in self.tn.listblocks:
                block_info = os.popen('bitcoin-cli -datadir=1 getblock '+str(block_hash)).read().replace('\n','')
                blockchain_writer.writerow([str(block_hash),str(block_info)])

    

def main():
    tests = Tests()
    tests.simple_fork()
    tests.prepare_balance_report()	
    tests.prepare_blockchain_report()
    

if __name__ == '__main__':
    main()
  


    	






