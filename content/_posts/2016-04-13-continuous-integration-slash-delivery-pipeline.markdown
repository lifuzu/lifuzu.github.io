---
layout: post
title: "Continuous Integration/Delivery Pipeline"
date: 2016-04-13 09:42:18 -0700
comments: true
categories: Continuous Integration Delivery
---

### Continuous Integration Pipeline
![enter image description here](https://lh3.googleusercontent.com/-vYfGCI7QdNQ/Vw52k6Q4XdI/AAAAAAAAEHg/FrNo5qzDlYY8QcdY0bzU4FOf6EuTUs-XgCLcB/s600/Gas-Pipelines-in-Columbia.jpg "Gas-Pipelines-in-Columbia.jpg")

Based on several software release engineering system, such as: Jenkins (include a bunch of Plugins), Gerrit, Git, Mocha, Nodejs and etc, we create a continuous integration pipeline to control source code, validation change(s), build artifact, report test results and deploy the artifacts to various deployment servers, just as: dev, staging, production (all groups). Here is a draft diagram we are trying to implement for Content Stream Application Service:

<!-- more -->

### Steps
![Continuous Integration Pipeline](https://lh3.googleusercontent.com/-H3FwqFg7z38/Vw50_hFK4tI/AAAAAAAAEHU/1lUUkyBENdUb64L1LA640DUUNewtn03dwCLcB/s1000/Continuous+Integration+Pipeline.png "Continuous Integration Pipeline.png")

Here are some explanations for a specific job of content stream, for example:

 - The job contentstream-**patchset** will be triggered automatically when
   one change is being pushed to Gerrit for review, it will set verify
   bit ‘+1’ for the review if the build successfully; or warn the
   submitter of the change if the build fail;
 - When any change is merged to the branch, for example, ‘master’, the
   job contentstream-**master** will be triggered automatically to verify
   the change if it affects the branch; 
 - The job contentstream-master-**release** is to make tag, push the tag to server
   to label a version of source code, which should be deployed to
   deployment servers some time later; 
 - The deployment jobs, like contentstream-master-**deploy**-to-* will deploy the source code to the dev|stag|prod (group1, group2, ...) servers according to the version which labeled on the release job as above;

> Written with [StackEdit](https://stackedit.io/).
