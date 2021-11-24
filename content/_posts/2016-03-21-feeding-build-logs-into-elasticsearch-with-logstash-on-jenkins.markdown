---
layout: post
title: "Feeding build logs into elasticsearch with logstash on Jenkins"
date: 2016-03-21 11:47:26 -0700
comments: true
categories: CI Elasticsearch Logstash Kibana Jenkins
---

### Elasticsearch
![enter image description here](https://lh3.googleusercontent.com/-AdsV-jHNTfA/VvBBBCryniI/AAAAAAAAEEk/LctcadsOSwAR2lnqdOxpxJUQdgurnCbHA/s600/BuildLogCollectionPipeline+%25282%2529.png "BuildLogCollectionPipeline.png")

Elasticsearch platform is designed to take data from any source and as a build guy, we create a lot of metadata every day, across Android, iOS, Windows platform, such as compiler warnings, errors, lint message, unit test reports, etc. Is it possible to collect such data, then store into Elasticsearch with Logstash plugins, then visualize them with Kibana?

In this article, we setup an Elasticsearch instance very quickly, with the support of elastic cloud, then config the Logstash plugin on Jenkins to feed log data into Elasticsearch space, then display the message with Kibana.

<!-- more -->

### Create elasticsearch instance on elastic cloud:
![enter image description here](https://lh3.googleusercontent.com/-xgIACl1UHFM/VuItxKcMS3I/AAAAAAAAECA/N78QxZachx0aMysdbsfY3VtcRgp40M6Xw/s600/Screen+Shot+2016-03-10+at+6.30.03+PM.png "Screen Shot 2016-03-10 at 6.30.03 PM.png")

### Install logstash plugin on Jenkins with Plugin Manager:
![enter image description here](https://lh3.googleusercontent.com/-fbTQCm8VCIo/VuIs5Qk7j5I/AAAAAAAAEBw/J_kEmkW-gf0Shr6Hi7GbuXYAoxVy-7GrQ/s1200/Screen+Shot+2016-03-10+at+6.25.34+PM.png "Screen Shot 2016-03-10 at 6.25.34 PM.png")

### Config logstash plugin as an agent:
![enter image description here](https://lh3.googleusercontent.com/-2XN3VyQvZhE/VuIt8XeDuLI/AAAAAAAAECI/SMd98pqVqdcpxZoYsFU4BNYZ8GQJIcWyw/s600/Screen+Shot+2016-03-10+at+6.28.10+PM.png "Screen Shot 2016-03-10 at 6.28.10 PM.png")

### Config logstash for each project:
![enter image description here](https://lh3.googleusercontent.com/-swBgeznEUNY/VuIuLocDnOI/AAAAAAAAECQ/pyA-RBdpM7cTVCOfaqo6e6uKY7P_fiNPg/s600/Screen+Shot+2016-03-10+at+6.31.52+PM.png "Screen Shot 2016-03-10 at 6.31.52 PM.png")
![enter image description here](https://lh3.googleusercontent.com/-9YqKZ39g248/VuIuQkOTPeI/AAAAAAAAECY/7J-PSi5O9UoDItYQC5j1kdPT_Yy91QHjw/s600/Screen+Shot+2016-03-10+at+6.31.39+PM.png "Screen Shot 2016-03-10 at 6.31.39 PM.png")

### Search message from Kibana Web UI:
![enter image description here](https://lh3.googleusercontent.com/-VvwIFnL0PLQ/VuIu_plyA4I/AAAAAAAAECw/k-2xBoXGfNI_AH4oRwZdPCdu5XVBRAQBA/s600/Screen+Shot+2016-03-10+at+6.35.05+PM.png "Screen Shot 2016-03-10 at 6.35.05 PM.png")

### Some useful URL to check status of elasticsearch:
Check health of elasticsearch:
```
http://02bb48d4a19b37090ea4ef33d4a4e596.us-west-1.aws.found.io:9200/_cat/health?v
```
Check indices (tables/contents) on elasticsearch:
```
http://02bb48d4a19b37090ea4ef33d4a4e596.us-west-1.aws.found.io:9200/_cat/indices?v
```

###References:
1. https://www.elastic.co/cloud
2. https://wiki.jenkins-ci.org/display/JENKINS/Logstash+Plugin

> Written with [StackEdit](https://stackedit.io/).
