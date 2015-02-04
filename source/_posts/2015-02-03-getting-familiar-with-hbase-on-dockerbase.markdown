---
layout: post
title: "Getting Familiar With HBase on Dockerbase"
date: 2015-02-03 21:34:36 -0800
comments: true
categories: dockerbase, hbase
---
![Apache HBase Logo](http://doc.mapr.com/download/attachments/26982553/hbase_logo.png)
Apache HBase is a distributed, scalable, big data store. With Apache HBase, you can randomly access your big data, which support realtime read/write. You can get more information about Apache HBase from the reference list [3]. This article introduces how to setup a standalone HBase database with Dockerbase supported.
<!--more-->
**Steps**:

*1*. Install Docker:
Install the latest version of Docker on Ubuntu:
``` bash
$ curl -sSL https://get.docker.com/ubuntu/ | sudo sh
$ docker --version
```
For Microsoft Windows or Mac OS, there is a tool named `boot2docker` [1] need to be installed to provide a terminal to run the following commands. You can also get more information about other platform you are on from reference [2].

*2*. Clone the Dockerbase HBase image from the public Docker hub registry [4]:
``` bash
$ sudo docker run -it --rm --name dockerbase-devbase-hbase dockerbase/devbase-hbase
```

*3*. After pulling the image, the Dockerbase image will run automatically into the docker container (docker container just like a lightweight virtual machine), then you can run the following commands to start Apache HBase, and then launch the shell to run the HBase commands:
``` bash
devbase@0be9d4455f59:~$ sudo -E bash -c '/usr/local/hbase/bin/start-hbase.sh'
devbase@0be9d4455f59:~$ hbase shell
hbase(main):001:0> list
TABLE

2015-02-02 20:03:28,604 WARN  [main] util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
0 row(s) in 1.1440 seconds

=> []
hbase(main):002:0> create 'test', 'cf'
0 row(s) in 0.2630 seconds

=> Hbase::Table - test
hbase(main):003:0> list 'test'
TABLE
test
1 row(s) in 0.0030 seconds

=> ["test"]
hbase(main):004:0> put 'test', 'row1', 'cf:a', 'value1'
0 row(s) in 0.0900 seconds

hbase(main):005:0> get 'test', 'row1'
COLUMN                                               CELL
 cf:a                                                timestamp=1422907465167, value=value1
1 row(s) in 0.0110 seconds

hbase(main):006:0> disable 'test'
0 row(s) in 1.2890 seconds

hbase(main):007:0> drop 'test'
0 row(s) in 0.2010 seconds
hbase(main):008:0> quit
devbase@0be9d4455f59:~$ sudo -E bash -c '/usr/local/hbase/bin/stop-hbase.sh'
```
From the above commands, we list the tables in database, then `create` a table named 'test'. We `put` some data into the table, then `get` it out with the `get` command. Before we `drop` the table, we have to `disable` it. The last step is to quit the Apache HBase shell.

You can find more Apache HBase shell commands from reference list [4] to practice in this Dockerbase image. Enjoy!

**References**:

1. http://boot2docker.io/
2. https://docs.docker.com/installation/
3. http://hbase.apache.org/
4. https://registry.hub.docker.com/u/dockerbase/devbase-hbase/
5. http://wiki.apache.org/hadoop/Hbase/Shell

> Written with [StackEdit](https://stackedit.io/).
