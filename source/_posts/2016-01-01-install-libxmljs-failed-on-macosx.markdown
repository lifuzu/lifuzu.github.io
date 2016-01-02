---
layout: post
title: "Install libxmljs failed on macosx"
date: 2016-01-01 15:59:11 -0800
comments: true
categories: libxmljs, compile, macosx
---
Today I am trying to install osmosis on macosx
```
npm i --save osmosis
```
libxmljs is one of the dependency of it, which is failed during installing, here is the error log:

```
...
3 warnings generated.
  CC(target) Release/obj.target/libxml/vendor/libxml/xpointer.o
  LIBTOOL-STATIC Release/xml.a
libtool: unrecognized option `-static'
libtool: Try `libtool --help' for more information.
make: *** [Release/xml.a] Error 1
gyp ERR! build error 
gyp ERR! stack Error: `make` failed with exit code: 2
...
```
<!-- more -->
Search with Google, found some cues, but not total same. I remember I installed libtool with port to fix a build error before, so the root cause should be two different libtools installed on my macosx:
```
$ which -a libtool
/usr/local/bin/libtool
/usr/bin/libtool
```
Verify if installed with `port`:
```
$ port installed
The following ports are currently installed:
  ...
  libtool @2.4.6_2 (active)
  ...
```
Uninstall the one which `port` installed:
```
$ sudo port uninstall libtool
```
Then try to compile libxmljs component:
```
...
3 warnings generated.
  CC(target) Release/obj.target/libxml/vendor/libxml/xpointer.o
  LIBTOOL-STATIC Release/xml.a
  CXX(target) Release/obj.target/xmljs/src/libxmljs.o
  CXX(target) Release/obj.target/xmljs/src/xml_attribute.o
  CXX(target) Release/obj.target/xmljs/src/xml_document.o
  CXX(target) Release/obj.target/xmljs/src/xml_element.o
  CXX(target) Release/obj.target/xmljs/src/xml_comment.o
  CXX(target) Release/obj.target/xmljs/src/xml_namespace.o
  CXX(target) Release/obj.target/xmljs/src/xml_node.o
  CXX(target) Release/obj.target/xmljs/src/xml_sax_parser.o
  CXX(target) Release/obj.target/xmljs/src/xml_syntax_error.o
  CXX(target) Release/obj.target/xmljs/src/xml_text.o
  CXX(target) Release/obj.target/xmljs/src/xml_xpath_context.o
  SOLINK(target) Release/xmljs.node
```
The problem is resolved!

###References:
1. https://github.com/Homebrew/homebrew/issues/28442
2. https://github.com/rc0x03/node-osmosis

> Written with [StackEdit](https://stackedit.io/).
