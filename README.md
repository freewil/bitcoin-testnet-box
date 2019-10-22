# bitcoin-testnet
This document will help you to run a 4-node bitcoin testnet and ib-seeder locally and observe the latter consuming testnet data into Postgres  

## Spin up bitcoin testnet and run tests

```
1.) docker build -t bitcoin-testnet .
2.) docker run -t -i -p 19001:19001 -p 19011:19011 -p 19021:19021 -p 19031:19031 bitcoin-testnet
```

Once inside the testnet container
```
3.) make start.   This all start 4 bitcoin servers
4.) python3 test_net.py
      Currently it simulates a simple fork that ib-seeder ingests. More use cases can/will be added
```

## Start CouchDB instance (in a separate terminal) (THIS STEP SHOULD BE DEPRECATED SOON AS WE ARE PHASING OUT COUCHDB)
```
5.) docker run -p 5984:5984 --env COUCHDB_USER=admin --env COUCHDB_PASSWORD=5Js2uGM1jMQt apache/couchdb:latest
```

##### Here you will run into a CouchDB issue
```
“chttpd_auth_cache changes listener died database_does_not_exist at mem3_shards:load_shards_from_db/6(line:395) <= mem3_shards:load_shards_from_disk/1(line:370) <= mem3_shards:load_shards_from_disk/2(line:399) <= mem3_shards:for_docid/3(line:86) <= fabric_doc_open:go/3(line:39) <= chttpd_auth_cache:ensure_auth_ddoc_exists/2(line:195) <= chttpd_auth_cache:listen_for_changes/1(line:142)
[error] 2019-11-01T16:17:12.628695Z nonode@nohost emulator -------- Error in process <0.345.0> with exit value:”

In order to stop these errors, execute the following commands
5a.) curl localhost:5984
{"couchdb":"Welcome","version":"2.3.1","git_sha":"c298091a4","uuid":"b05d506b17b8624830bdba7685e1b146","features":["pluggable-storage-engines","scheduler"],"vendor":{"name":"The Apache Software Foundation"}}
5b.) curl -X PUT http://admin:5Js2uGM1jMQt@localhost:5984/_users
{"ok":true}
5c.) curl -X PUT http://admin:5Js2uGM1jMQt@localhost:5984/_replicator
{"ok":true}
5d.) curl -X PUT http://admin:5Js2uGM1jMQt@localhost:5984/_global_changes
{"ok":true}
```

## Start Influx and Postgres Services

```
6.) docker-compose up influx postgres .
Clone [ib-services](https://github.com/chainalysis/ib-services/). 
```

## Run ib-seeder
```
7.)  ./gradlew clean build && java -jar build/libs/ib-seeder-all.jar
Clone [ib-seeder](https://github.com/chainalysis/ib-seeder).  Under application.properties, have the following values
seeder.isPsql=true
btc.enabled=true
btc.rpc.url=http://127.0.0.1:19001
btc.rpc.threads=10
btc.rpc.user=admin1
btc.rpc.password=1234
```

## Connect to Postgres container to observe Data flow into jsondb
```
8.) exec -it <container_id> psql -U user
```
