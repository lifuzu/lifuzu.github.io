---
layout: post
title: "Setup Mongo Database Master Slave Replication"
date: 2015-01-07 13:58:40 -0800
comments: true
categories: database, admin
---

![enter image description here](http://tapainc.com/images/MongoDB.png)

**Prerequisites**:

You need know the IP or hostname of the Mongo database which should be acted as a master, and you can ping the port 27017 from the mongo database which should be acted as a slave.

Here are some commands might be helpful:

* To know the external IP of the server:
```
$ curl http://checkip.dyndns.org/
```

* To ping the server which you want to connect, on the specific port ( for example: 27017 ):
```
$ telnet 1.2.3.4 27017
```

**Practices**:

Machine A (Master):
Run Mongo Daemon as master:
```bash
$ mongod --master
```

Machine B (Slave):
If mongod is running, which is the default behavior when installed, you should stop it before the following steps:
```bash
# Stop the mongodb which installed by default
$ sudo stop mongodb
```
Run Mongo Daemon as slave:
```bash
$ mongod --slave
```
Probably you need to specify the dbpath, in case you have any disk space limitation:
```bash
$ sudo mongod --slave --dbpath /data/mongodb/
```

Run `mongo` to open a mongo shell, then config for replication:
```
> use local
> db.sources.find()
> db.sources.insert( { host: <masterhostname> <,only: databasename> } );
```
Then you run `show dbs` in the mongo shell:
```
> show dbs
```
You will find the databasename which we typed behind the `only` key above displayed.

You may need to run the command multiple times to make sure the replication is going on. For example:
```
> show dbs
databasename    17.9453125GB
local   0.078125GB
> show dbs
databasename    19.9443359375GB
```

You can also run the following commands to show the information of the replication on master and slave side:
```bash
# Master side:
> rs.printReplicationInfo() # replace 'rs' to 'db' for the version prior to 2.6

# Slave side:
> rs.printSlaveReplicationInfo() # same thing as the above command, you need to replace 'rs' to 'db' if you run the mongodb which version prior to 2.6
```

Besides, you can run the following command to get a defail status of the server:
```
> db.serverStatus()
```

You might neet to run resync to recover replication:
```
> use admin
> db.runCommand( { resync: 1 } )
```

**References**:

1. http://docs.mongodb.org/manual/core/master-slave/

> Written with [StackEdit](https://stackedit.io/).

