---
layout: post
title: "Playing with Hadoop on Dockerbase"
date: 2015-02-03 21:52:03 -0800
comments: true
categories: dockerbase, hadoop 
---
![Apache Hadoop Logo](https://www.ombud.com/asset/3607)
Apache Hadoop is a map reduce computing environment, which provide a reliable, scalable and distributed computing environment to handle big data. This article introduce how to setup a Apache Hadoop Dockerbase image to play with the standalone operation of Hadoop on Docker.
<!--more-->
**Steps**:

*1*. Install Docker:
Install the latest version of Docker on Ubuntu:
``` bash
$ curl -sSL https://get.docker.com/ubuntu/ | sudo sh
$ docker --version
```
For Microsoft Windows or Mac OS, there is a tool named `boot2docker` [1] need to be installed to provide a terminal to run the following commands. You can also get more information about other platform you are on from reference [2].

*2*. Download Dockerbase image for Hadoop:
``` bash
$ sudo docker run -it --rm --name dockerbase-devbase-hadoop dockerbase/devbase-hadoop
```
It takes a little bit time (depends on network speed) to download docker image from public Docker hub registry [3].

*3*. Enter Docker image automatically after the above step, try the command `hadoop` to display usage documentation for the hadoop script:
``` bash
devbase@145878b9c8c7:~$ hadoop
Usage: hadoop [--config confdir] COMMAND
       where COMMAND is one of:
  fs                   run a generic filesystem user client
  version              print the version
  jar <jar>            run a jar file
  checknative [-a|-h]  check native hadoop and compression libraries availability
  distcp <srcurl> <desturl> copy file or directories recursively
  archive -archiveName NAME -p <parent path> <src>* <dest> create a hadoop archive
  classpath            prints the class path needed to get the
                       Hadoop jar and the required libraries
  daemonlog            get/set the log level for each daemon
 or
  CLASSNAME            run the class named CLASSNAME
```
*4*. The following example copies configuration files under the `hadoop` folder which we installed in `/usr/local`, then run the `hadoop` command to find every match of the given regular expression.
``` bash
devbase@145878b9c8c7:~$ mkdir input
devbase@145878b9c8c7:~$ cp /usr/local/hadoop/etc/hadoop/*.xml input/
devbase@145878b9c8c7:~$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar grep input output 'dfs[a-z.]+'
15/02/03 17:49:21 INFO Configuration.deprecation: session.id is deprecated. Instead, use dfs.metrics.session-id
15/02/03 17:49:21 INFO jvm.JvmMetrics: Initializing JVM Metrics with processName=JobTracker, sessionId=
15/02/03 17:49:22 WARN mapreduce.JobSubmitter: No job jar file set.  User classes may not be found. See Job or Job#setJar(String).
...
```
*5*. Display the matchs from the output folder:
``` bash
devbase@145878b9c8c7:~$ cat output/*
1	dfsadmin
```

**References**:

1. http://boot2docker.io/
2. https://docs.docker.com/installation/
3. https://registry.hub.docker.com/u/dockerbase/devbase-hadoop/
4. http://hadoop.apache.org/
 
> Written with [StackEdit](https://stackedit.io/).
