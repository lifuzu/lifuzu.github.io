---
layout: post
title: "Wordpress in Docker"
date: 2015-10-05 22:52:37 -0700
comments: true
categories: docker wordpress
---
![enter image description here](http://blog.loadimpact.com/wp-content/uploads/2014/12/WordPress-Docker.png)
### Install docker container
On Windows/MacOS X, please go to Docker-toolbox: https://www.docker.com/toolbox
Following the instruction to install docker-toolbox;

### Open the docker quickstart terminal:
![enter image description here](https://lh3.googleusercontent.com/-Ku1FRq1LhCM/VhNc3Asx9RI/AAAAAAAADmk/wW1l3jUqF-g/s600/Screen+Shot+2015-10-05+at+10.30.59+PM.png "Screen Shot 2015-10-05 at 10.30.59 PM.png")
<!-- more -->
### Install mysql database
```
$ docker pull mysql
```

### Install wordpress application
```
$ docker pull wordpress
```

### Compose the application with database, with a file named: `docker-compose.yml`
```yml
wordpress:
  image: wordpress
  links:
    - db:mysql
  ports:
    - 8080:80

  net: "bridge"
  dns:
    - 8.8.8.8
    - 4.4.4.4

db:
  image: mysql
  environment:
    MYSQL_ROOT_PASSWORD: example
```

### Launch the composed service
```
$ docker-compose up
```
The service should be launched as following:
```console
db_1        | 2015-10-06 05:13:50 1 [Note] Event Scheduler: Loaded 0 events
db_1        | 2015-10-06 05:13:50 1 [Note] mysqld: ready for connections.
db_1        | Version: '5.6.27'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
wordpress_1 | WordPress not found in /var/www/html - copying now
wordpress_1 | Complete! WordPress has been successfully copied to /var/www/html
wordpress_1 | AH00558: apache2: Could not reliably determine the server's fully
wordpress_1 | [Tue Oct 06 05:15:13.163996 2015] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.10 (Debian) PHP/5.6.14 configured -- resuming normal operations
wordpress_1 | [Tue Oct 06 05:15:13.164050 2015] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
```

Or run as background processes:
```
$ docker-compose up -d
```
The output console should like:
```
Starting wordpress_db_1...
Starting wordpress_wordpress_1...
```

You can take a look the background containers:
```
$ docker-compose ps
        Name                       Command               State          Ports         
-------------------------------------------------------------------------------------
wordpress_db_1          /entrypoint.sh mysqld            Up      3306/tcp             
wordpress_wordpress_1   /entrypoint.sh apache2-for ...   Up      0.0.0.0:8888->80/tcp 
```

Or stop the composed containers:
```
$ docker-compose stop
Stopping wordpress_wordpress_1... done
Stopping wordpress_db_1... done
```


### Access the service with 2 steps:
```
# Get your container IP address (from another console):
$ docker-machine ls # to get the launched container
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM
default            virtualbox   Running   tcp://192.168.99.100:2376

$ docker-machine ip default
192.168.99.100
```
Now you can open a browser then try to access:
```
http://192.168.99.100:8080
```
Done!

##References:
1. https://docs.docker.com/compose/

> Written with [StackEdit](https://stackedit.io/).
