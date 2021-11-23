---
layout: post
title: "Design a reuse and 'de-use' modularized software system"
date: 2015-01-14 09:49:13 -0800
comments: true
categories: Software engineering 
---

![enter image description here](http://www.edmentum.com/sites/edmentum.com/files/solutions/content/building_0.jpg)

Design a reuse and 'de-use' modularized software system
-------------------------------------------------------

**Keywords**: reuse, 'de-use', minimum equipped interface (MEI), strong cohesion, loose coupling, software engineering

Most of the task on software design are to analyze requirements, decompose functionalities and connect the parts of artifacts to fulfill customer requirements.

This time we focus on decomposition of functionalities. Why we need to decompose the requirements to each small module or package, one of the reasons is to reuse them, another reason, I think, is to 'de-use' them. When we do not need any of modules, we can separate them from system very easily, which also provide much convenience for testing. We can test each of the seperated modules, packages or interfaces isolated, without interference between each other.

The goal of the software design, include architectural design and detail design, is to decompose functionalities with the characteristics of strong cohesive, and loose coupled, which means we need a complete, but most minimal system function set. Interface is a very important element between two systems to access those functionalities, in addition to deployment environment. In fact, we can treat the environment as the interface between system and the system host. So we need a minimum equipped interface (MEI), which refers to Minimum Viable Product (MVP) definition.

To achieve the goal, besides an elegant design blueprint, functional prototyping, we also need supports from configuration management and testing. We should have many different configuration profiles to include or exclude the modules according to the reuse and 'de-use' specifications, which we planned in design. Testing should have different test scenarios to verify and/or validate the interfaces, which are exported by modules or packages according the configuration profiles.

Succeed to DCOM and CORBA, the popular technology so far for designing a strong cohesive and loose coupled interface on cloud is REST, which based on the simple HTTP protocol verbs (GET, PUT, POST, DELETE). REST API is an analogous to SQL for interaction between systems on cloud, the latter provides several common verbs to query and manipulate data with relational database, such as SELECT, INSERT, UPDATE, DELETE, etc.

In a conclusion, as the main task for design, we need to decompose functionalities in order to reuse and 'de-use' modules, which act as a container to host functions. The design goal is to make functionality as most as strong cohesive, and loose coupled. We can leverage configuration management and testing to achieve the design goal. REST interface provides a good practice for designing a strong cohesive, and loose coupled cloud system.

> Written with [StackEdit](https://stackedit.io/).
