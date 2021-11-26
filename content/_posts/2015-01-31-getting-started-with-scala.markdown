---
layout: post
title: "Getting Started with Scala"
date: 2015-01-31 21:58:42 -0800
comments: true
categories: programming, Scala 
---
![enter image description here](../images/Scala-full-color.svg "Scala")
Have no any idea what to do today after dinner, although I have some homeworks need to submit soon, I still decided to try something new in a short time. I recalled I read an article yesterday on stackshare.io, it seems there is a company named instacarts tried Scala programming language to setup their development stack. I am very curious on the programming language, it seems someone said: "Speaking More Than One Language Could Sharpen Your Brain." How about Scala?

<!-- more -->
**Steps**:

*1*. Download the recent Scala SDK here:
```bash
$ wget http://downloads.typesafe.com/scala/2.11.5/scala-2.11.5.tgz
```

*2*. Uncompress the package, put the folder into `/usr/local`, add the path into system environment variable `PATH`:
```bash
$ cd /usr/local
$ sudo tar -zxf ~/Downloads/scala-2.11.5.tgz
$ sudo ln -s scala-2.11.5 scala
$ vi ~/.bashrc
$ export SCALA_HOME=/usr/local/scala
$ export PATH=$PATH:$SCALA_HOME/bin
```
*NOTE*: You can skip the above two steps with a full-fledged docker image, which even do not affect your local system, but allow you to try the following steps. Please see the instruction on how to download the docker image on Scala at the bottom.

*3*. Open your perfered Editor, for me, it is sublime text and/or vi, type the followind code in:
``` scala
object HelloScala {
  def main(args: Array[String]) {
    println("Hello Scala!")
  }
}
```
then save the file as `helloscala.scala`

*NOTE*: If you do not want to type them in, please git clone the repository in my github here:
```bash
git clone https://github.com/lifuzu/HelloScala
```

*4*. Compile and execute it:
```bash
$ scalac HelloScala.scala
$ scala HelloScala
Hello Scala!
```

*5*. We can even ignore to add a method `main` to be act as the entry point of the program by extending object from `App`, like:
``` scala
object HelloScala extends App {
  println("Hello, Scala!")
}
```

Cool! You are almost done. Scala has two surprises here for you!

*6*. The first surprise with Scala is we can easily to script it with bash shell script, like:
``` scala
#!/bin/bash
exec scala "$0" "$@"
!#
object HelloScala extends App {
  println("Hello, Scala!")
}
HelloScala.main(args)
```
Save it as `helloscala.sh`, then run it as:
```bash
$ chmod +x helloscala.sh
$ ./helloscala.sh
```
OR
```bash
$ bash helloscala.sh
```

*7*. Scala provide a REPL interactive shell to allow developers to try some short experiments:
```bash
$ scala
...
scala> object HelloScala extends App {
    |    println("Hello, Scala!")
    |  }
defined object HelloScala

scala> HelloScala.main(null)
Hello, Scala!

scala> :q
$
```

**Dockerbase information**:
If you are on Ubuntu, or other linux, please make sure your have `docker` command on your terminal, please try the command here:
```bash
$ docker --version
Docker version 1.4.1, build 5bc2ff8
```
You should get a version of docker above `1.2.0`, then run the command ( it will take a little bit time to download docker image at first time ):
```bash
$ docker run -it --rm --name dockerbase-devbase-scala dockerbase/devbase-scala
```
*NOTE*: With the option `--rm`, docker will remove the container when it exits automatically. Please make sure you save your documents before type `exit` from docker container.

On Mac, please refer to the ref[2] for Boot2Docker.

**References**:

1. https://registry.hub.docker.com/u/dockerbase/devbase-scala/
2. https://docs.docker.com/installation/mac/
3. http://www.scala-lang.org/documentation/getting-started.html
4. https://github.com/lifuzu/HelloScala

> Written with [StackEdit](https://stackedit.io/).
