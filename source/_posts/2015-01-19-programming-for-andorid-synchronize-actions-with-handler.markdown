---
layout: post
title: "Programming for Andorid: Synchronize actions with Handler"
date: 2015-01-19 20:32:10 -0800
comments: true
categories: development, android
---

![enter image description here](http://rxtracepz.dirkrodgersconsu.netdna-cdn.com/wp-content/uploads/2010/02/synchronized-swimmers.jpg)

Sometimes, we need to synchronize the actions in a series but not in parallel. For example, we need to download an image then display it on Google Gallery. It seems we cannot display a partial image during downloading. OK, there is another story, probably, we will mention later, for displaying image with a coarse one then detailed the clear picture. Now let's fix how to download an image then display it, without manual interference.

This program bases on the last one: [Programming for Android: Download, Progressbar and FileProvider](http://lifuzu.com/blog/2015/01/16/programming-for-android-download/)
<!--more-->
**Steps**:

*1*. Declare a handler and a message ID, which we need to indicate what action is completed:
```java
    Handler handler;
    private static final int DOWNLOAD_COMPLETED = 0;
```

*2*. Send out the message, when the first action is completed:
```java
                    // send message to trigger the following event
                    Message msg = Message.obtain();
                    msg.what = DOWNLOAD_COMPLETED;
                    handler.sendMessage(msg);
```

*3*. Handle the message, then trigger the following action(s):
```java
        handler = new Handler() {
            @Override
            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case DOWNLOAD_COMPLETED:
                        startDisplay();
                        break;
                }
            }
        };
```

You can clone the entire source code [here](https://github.com/lifuzu/FileProviderExample) [2].

**References**:

1. http://stackoverflow.com/questions/4592716/multithreading-question
2. https://github.com/lifuzu/FileProviderExample

> Written with [StackEdit](https://stackedit.io/).
