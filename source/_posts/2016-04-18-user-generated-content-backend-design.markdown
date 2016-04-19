---
layout: post
title: "User Generated Content Backend Design"
date: 2016-04-18 22:44:27 -0700
comments: true
categories: design backend UGC
---
###User Generated Content Backend Design
![enter image description here](https://lh3.googleusercontent.com/-_Gyq2BrP680/VxW8wprqROI/AAAAAAAAEIU/JTX430yak3MIzuwq9Z5GRjexHiwcxwLmACLcB/s1000/back-end-mobile-design-banner.png "back-end-mobile-design-banner.png")

Most of time, web browser or mobile platform user only care how to get information from web or apps, they send GET on http protocol much more than POST/PUT. However, as one of our application required, we have to handle the requests which user submit contents to backend server.

We design the process in asynchronized way. User submit contents, once the 1st tier server (as the figure below) - mainly act as a database with a REST Interface - receive and save the contents, the server send back a response immediately to user, which indicates that user submit successfully.

<!-- more -->

![enter image description here](https://lh3.googleusercontent.com/-Pn33GdV6ATc/VxW9ADoVuuI/AAAAAAAAEIc/eEv5_BVLbaUnUSGf52dh_sepQytQRLHoACLcB/s1000/Backend_Design.png "Backend_Design.png")

However, the raw information saved to the 1st tier server doesn't mean we don't handle it soon. Sometimes, handling the information takes much time, such as making a compilation, parsing some web pages, creating a batch of email and/or sending some of the emails. In case to interrupt the previous process by the following requests, we build a message queue to adapt the messages with the asynchronized method. When more requests are coming, we can easily scale up with setting more processes to handle the jobs, and when requests decrease, we suspend some of them to save resources.

There are several solutions to support message queue with the existing services, such as SQS from Amazon, RabbitMQ as a Service from CloudAMQP, or Beanstalkd if like to host. We need them to provide APIs to trigger or be pulled by the handling processes to complete the jobs in a line or several lines.

Once the jobs have been handled, some contents have to be created and saved to content server, such as articles, and images which embedded in the articles. We put the contents, including images to a backend server - or 2nd tier server - and return the link and/or metadata to the 1st tier database server for providing quick responses to the coming requests.

#### Options for Components
For the 1st tier database server, I prefer to using Parse.com, or self-host CouchDB, which act as a thin layer of service, sort of cache, but persistent. Of course, for performance, we can add one more layer as cache on top, such as memcache, and even cache cluster.

We used to create and host own processing servers, now there are a bunch of continuous integration server can be used as a processing server, such as wercker.com, bitrise.com, if prefer to own and host, Jenkins is another good option, or Runner which come from gitlab.com

Content server is to store contents, like web pages (for social sharing to Facebook, Twitter, Wechat, etc.), images. Wordpress with the REST API plugin support is a good solution. You can submit a new post through REST API, then get the generated result to know what is the public URL for the article, then save the public URL to the 1st tier database for rapid responses.

AWS S3 is an alternative to Wordpress, S3 is more static then WordPress, since WordPress equiped with MySQL database which supports dynamic contents easier. However, storing images, css, javascript on S3 then cache to CDN is more popular solution than only rely on Wordpress for all of the contents.

Authenticate is an individual task, which we can leverage the 3rd party vendor with their services. Please refer to the Ref #1 for detail information.


###References:
1. Authenticate Vendor - http://www.auth0.com
2. Processing server - http://www.wercker.com
3. RabbitMQ as a service - https://www.cloudamqp.com/

> Written with [StackEdit](https://stackedit.io/).
