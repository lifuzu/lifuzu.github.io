---
layout: post
title: "Using git command to find build failure very quickly"
date: 2015-06-02 10:32:09 -0700
comments: true
categories: build, git
---
When some changes broke your build during the mid night, how to find the culprit of the failure very quickly? Like this:
![build failure history](https://lh3.googleusercontent.com/-20gdQ7Sswwk/VW3cw-UhgWI/AAAAAAAAC04/b3cysga0Cr8/s0/Screen+Shot+2015-06-02+at+9.39.06+AM.png "Screen Shot 2015-06-02 at 9.39.06 AM.png")

If you are using git as your version control system, then the short answer is '**git bisect**'.

As the above screenshot, you know the latest good version is 4.7.0.310, and the earliest bad version is 4.7.0.311, so some changes between the two version failed the build. Then how to use 'git bisect' to help us debug the issue very quickly?
<!--more-->
Firstly, checking out the source tree to an environment:
```
$ git clone ...
```
Starting the git bisect command:
```
$ git bisect start
```
Marking the good version and the bad one with the tag name (or commit id):
```
$ git bisect good 4.7.0.310
$ git bisect bad 4.7.0.311
```
Then git bisect analyzes the changes between, checkout the middle one (bisected) to the current environment and wait for verification. What we need to do now is just to run the build command to get the build result for the snapshot:
```
$ ./gradlew clean build
```
If the build failed, then mark it bad:
```
$ git bisect bad
```
Git should checkout another version between this one and the good one, bisectedly. Then what we need to do is to run the build command again to get the build result:
```
$ ./gradlew clean build
```
If the build is successful, then git should bisect to another version between this one and the latest verified bad one. Until git find which commit failed the build. 

Assuming you mark the build is successful, and git find out which commit is the root cause, it should display the commit after the mark command immediately:
```
$ git bisect good
f0810993941d6bc2f4985c9830780f5bc86e0f35 is the first bad commit
commit f0810993941d6bc2f4985c9830780f5bc86e0f35
Author: ABC <abc@abc.com>
Date:   Tue Jun 2 15:14:09 2015 +0800

    ABC-1234: move a function to another class to avoid ClassNotFound if API level < 18

:040000 040000 56a19c7814dea9aee78bf3453c223e428a31e451 29a6fbc67b3d1e521683739270b186a86f6f9240 M	abcmoduleA
:040000 040000 f9045aaf28eef5c250d110c4580c76ed90a642eb 8ddeced2ceaa41a0d93ba8b1f6333976f6104342 M	abcmoduleB
```

Done!

> Written with [StackEdit](https://stackedit.io/).
