---
layout: post
title: "Gevent, Eventlet和Node.js的性能分析"
date: 2014-01-05 22:13:56 -0800
comments: true
categories: 
---

原文地址：http://myprogrammingjourney.blogspot.com/2011/03/meet-my-three-new-friends-eve-eventlet.html

碰到了我的三个朋友：Eve ([Eventlet][1])和他的小弟Geve([Gevent][2])，以及Node(nodejs.org)。全部三个都承诺对于响应多个Web客户端的请求的可扩展性。Eve是第一个轻巧的、非阻塞I/O 的python网络库。Eve的灵感来自于一个兽名Twisted，后者也提供了非阻塞I/O，但很重量级，不易tame。因此Eve为下一代轻量级的，可扩展的网络库铺平了道路。Geve虽然开始时是一个更年轻和更小的Eve版本，随着一些重大的修改，现在也已经发展成为最强大的Python网络库。它可以毫不费力地处理来自Web客户端的多个并发请求，很容易理解和实现。现在，这些Python脚本可以用来设计网页爬虫，网络机器人或Python/WSGI服务器，设计者真的很高兴能使用这些库来把他们的应用程序提升到一个新的水平。

一个Python的Web应用程序都有两个方面：服务器编程（在Python中完成）和客户端编程（使用HTML，CSS和JavaScript来完成）。Node.js通过提供一个JavaScript的Web开发框架，内置了一个高效的连接服务器和客户端编程之间的的HTTP 服务器。这个服务器也是可扩展的，重量轻，提供异步，非阻塞I/O。Node.js服务器其实更优于它的对手Python。Node.js允许服务器和客户端脚本都使用JavaScript。现在，这点对许多JavaScript程序员来说是个好消息。他们曾经对不能控制服务器端编程有点困惑。Node.js提供的服务器是强大的，但框架非常简单，需要许多组件支持。但是，随着Node.js的日益普及，越来越多的人也没闲着，他们提供一些有效的框架来支持Node.js。[Express][3]就是其中一种。在[npm][4]资源库中人们可以找到一些真正有用的JavaScript模块，这些模块是其他人在面临同样问题时开发的。这些模块都是免费的有点像Python cheese shop（PyPi）。 
<!--more-->
无论怎么样，我想使用Apache Benchmark测试这三个框架。就是利用这三个朋友创建三个简单的服务器，然后利用Apache Benchmark抛出多个并发请求，看他们如何响应。对于服务器而言，就是返回一个简单的 Hello World 字符串。看看我们的代码：

先来Gevent：
{% gist 8278468 geve.py %}

保存上述脚本为geve.py，在终端执行“$python geve.py”，这将触发Gevent服务器，端口为8912。现在在另一个终端窗口运行：
```
ab -n 1000 -c 100 http://localhost:8912/
```
上述命令运行用ab发出1000个请求（-n），100个并发请求（-c）到服务器。你可以改变的数字，这个取决于你的操作系统能力。检查以下行：“Time taken for tests:”，我这里的数字是：**0.360**秒。如下：

{% gist 8278468 ab_gevent.log %}

现在是Eventlet：
{% gist 8278468 eve.py %}

保存为eve.py，然后用ab运行:
```
ab -n 1000 -c 100 http://localhost:6785/
```
结果是**0.639**秒。（注意区别）

{% gist 8278468 ab_eventlet.log %}

最后但并非最不重要的Node.js：

{% gist 8278468 node.js %}

其结果是**0.186**秒（好吧，这个是最好的结果）。

{% gist 8278468 ab_nodejs.log %}

该分析在Ubunut（12.04.3）上执行。这里是[硬件][5]以及[软件][6]信息。欢迎留下评论和分享您的经验。

> Written with [StackEdit](https://stackedit.io/).


  [1]: eventlet.net
  [2]: gevent.org
  [3]: http://expressjs.com/
  [4]: https://npmjs.org/
  [5]: https://gist.github.com/lifuzu/8278468/raw/c92933b471c63ed2b607ad09551655ba3274392d/hardware.info
  [6]: https://gist.github.com/lifuzu/8278468/raw/ddb00a3d17f951c61a5a3deda272dd337bd27859/software.info
