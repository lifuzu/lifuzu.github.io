---
layout: post
title: "Playing with iOS background multitasking"
date: 2015-08-05 22:45:30 -0700
comments: true
categories: iOS, background multitask
---
![enter image description here](https://possiblemobile.com/wp-content/uploads/2013/09/ios7_dev.png)

In the realm of the background multitasking, Apple has made some significant changes by exposing additional APIs since iOS7.​ iOS7 introduced some new background task handlings that help developers achieve some great user experiences, just like schedule the content update some spefice times, or allow the app to launch immediately whenever you send it a special push notification. They are called 'background app fetch' and 'remote notifications' correspondingly.
<!--more-->
Let's see how to configure the features:

![iOS_Background_Configuration](https://lh3.googleusercontent.com/-DbJXdNazt6U/VcGhOILO4SI/AAAAAAAADeM/hAZE32GW29o/s600/Screen+Shot+2015-08-04+at+10.00.28+PM.png "Screen Shot 2015-08-04 at 10.00.28 PM.png")

To implement 'background app fetch', only two steps needed:

*1*. Set the minimum background fetch interval in the application:didFinishLaunchingWithOptions: method of the AppDelegate:

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // Override point for customization after application launch.
        [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
        return YES;
    }

*2*. Implement a new AppDelegate method when the App is background launched called application:performFetchWithCompletionHandler:

    - (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
        NSLog(@"Background Fetch: Called in the background!");
        completionHandler(UIBackgroundFetchResultNewData);
    }

 To test the functionality, Xcode provide a very nice method under the menu 'Debug', called "Simulate Background Fetch":

![enter image description here](https://lh3.googleusercontent.com/-C0iXBlzT4Fo/VcGhuXcIqCI/AAAAAAAADeY/NOXFTfPl1Bo/s600/Debug_Background_Fetch.png "Debug_Background_Fetch.png")

After selecting the submenu, Xcode will close your application in the simulator, sending it to the background, and call the application:performFetchWithCompletionHandler: that we added. You should have something printed in the console window now, like this (in the red rectangle):

![enter image description here](https://lh3.googleusercontent.com/-SAUI2F65duk/VcGh1YdIBII/AAAAAAAADek/KXGv1upNkLc/s600/Screen+Shot+2015-08-04+at+10.07.15+PM.png "Screen Shot 2015-08-04 at 10.07.15 PM.png")

There are more steps to implment "remote notification", please refer to the following links:
http://www.huffingtonpost.com/dulio-denis/ios-quick-read-implementi_2_b_5351099.html
https://parse.com/tutorials/ios-push-notifications    
https://developer.apple.com/notifications/

Here is the github repository for your reference as well:
https://github.com/lifuzu/iOSBackground.git

Hope this can help you.

> Written with [StackEdit](https://stackedit.io/).
