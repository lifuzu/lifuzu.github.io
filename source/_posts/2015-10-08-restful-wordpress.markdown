---
layout: post
title: "RESTful WordPress"
date: 2015-10-08 22:36:58 -0700
comments: true
categories: RESTful WordPress
---
![enter image description here](http://www.codediesel.com/wp-content/uploads/2015/07/wordpress-rest-api.jpg)
This article introduce how to launch and config WordPress at first time, based on the composed WordPress docker container. With the several WordPress plugins, setup the RESTful API and config their permissions to register users, create new posts etc.
<!-- more -->
At first, please following the [previous post](http://lifuzu.com/blog/2015/10/05/wordpress-in-docker/) to compose the latest WordPress docker container.

### Start the composed WordPress docker container
```
# Inside the directory contained docker-compose.yml
$ docker-compose up -d
```

You should be able to get the container IP address (not localhost, or 127.0.0.1) with the commands:
```
# 1. to find the launched container
$ docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM
default            virtualbox   Running   tcp://192.168.99.100:2376

# 2. to address the IP address with the name
$ docker-machine ip default
192.168.99.100
```
Now open a browser to access the IP address with the port which set up in the composed yaml file: `docker-compose.yml`:
```
http://192.168.99.100:8080
```

### Config WordPress with a blog name and admin account
At the very beginning, you should get the following web interface:
![enter image description here](https://lh3.googleusercontent.com/-t0RPSrXRc5c/VhdEXMZ-W3I/AAAAAAAADnE/jSkbOTK9-AE/s600/Screen+Shot+2015-10-08+at+9.28.34+PM.png "Screen Shot 2015-10-08 at 9.28.34 PM.png")

Selecting your favorite language, then click "Continue". At the next UI, you have to input some critical information, like site title, the first user name, password and email address. The first user should be the administrator for this installation by default. (You can change them all after the first successful login):    

![enter image description here](https://lh3.googleusercontent.com/-c2yoHZQahOE/VhdE3jCBemI/AAAAAAAADnQ/ilowua9GOjs/s600/Screen+Shot+2015-10-08+at+9.34.00+PM.png "Screen Shot 2015-10-08 at 9.34.00 PM.png")    
After clicking "Install WordPress" button at bottom, several seconds later, the WordPress is ready on your machine.

Login WordPress with your first user name and password:
![enter image description here](https://lh3.googleusercontent.com/--QsmbOgVBZs/VhdE--mE81I/AAAAAAAADnc/K0E5hPLukaA/s600/Screen+Shot+2015-10-08+at+9.34.45+PM.png "Screen Shot 2015-10-08 at 9.34.45 PM.png")

Then done, WordPress admin UI is displayed:
![enter image description here](https://lh3.googleusercontent.com/-ZQ0RrnS4vbY/VhdFDqkfgZI/AAAAAAAADno/G9TOX6DYPgM/s600/Screen+Shot+2015-10-08+at+9.35.03+PM.png "Screen Shot 2015-10-08 at 9.35.03 PM.png")

### Install some plugins for RESTful api
For mobile development, we have to install some plugins to support RESTful API, which should be used to connect WordPress server from the mobile clients.

The first plugin is "JSON API". "JSON PAI" provides a lot of functions, such as create new posts, remove posts, etc. Click "Plugins" at the left sidemenu, then "Add New":
![enter image description here](https://lh3.googleusercontent.com/-x6L0YZY6rL4/VhdHr1UqV1I/AAAAAAAADoE/L6VwIAAqZoQ/s600/Screen+Shot+2015-10-08+at+9.46.14+PM.png "Screen Shot 2015-10-08 at 9.46.14 PM.png")

Put the name "json api" into the search box, push the "return" on keyboard:
![enter image description here](https://lh3.googleusercontent.com/-motAYH89BYk/VhdIGTcWlGI/AAAAAAAADoQ/4Aun05CcJgQ/s600/Screen+Shot+2015-10-08+at+9.46.31+PM.png "Screen Shot 2015-10-08 at 9.46.31 PM.png")

Click the "Install Now" button just below "JSON API", WordPress will start to install the plugin. However, after intallation is finish, you have to click the "Activate Plugin" link as the following image:    

![enter image description here](https://lh3.googleusercontent.com/-6k_fMuywkbA/VhdIZwoWmOI/AAAAAAAADoc/P0W3GhkddZw/s600/Screen+Shot+2015-10-08+at+9.48.33+PM.png "Screen Shot 2015-10-08 at 9.48.33 PM.png")

Same process for the second plugin "JSON API User". This plugin provides some useful functions to register and/or create new user with the RESTful api on WordPress. Eventually, you should get the following picture to make sure the plugins are ready for the next steps here:
![enter image description here](https://lh3.googleusercontent.com/-DHi_aAoHdro/VhdJTWWJFNI/AAAAAAAADow/qhms7BRvITs/s600/Screen+Shot+2015-10-08+at+9.49.42+PM.png "Screen Shot 2015-10-08 at 9.49.42 PM.png")

### Config the permission for registering user, creating post, etc.
Once the plugins installed, we still need to config these plugins to activate the functionalities according your requirements. Click "Settings" from the left sidemenu, then "JSON API":
![enter image description here](https://lh3.googleusercontent.com/-xPKPdWNRCCk/VhdKVPHzwDI/AAAAAAAADpQ/Su0b6JpskBo/s600/Screen+Shot+2015-10-08+at+10.01.56+PM.png "Screen Shot 2015-10-08 at 10.01.56 PM.png")

You should find all but "Core" functionality need to be "Activate"d, like:
![enter image description here](https://lh3.googleusercontent.com/-uxMEHqUWApo/VhdLYbjk36I/AAAAAAAADps/T86uIFtR8I0/s600/Screen+Shot+2015-10-08+at+10.03.00+PM.png "Screen Shot 2015-10-08 at 10.03.00 PM.png")

Turn "Posts" and "User" on by clicking the link just below them, as:
![enter image description here](https://lh3.googleusercontent.com/-c6e7DuahoDY/VhdLR61wSVI/AAAAAAAADpg/2x4UvpOoITE/s600/Screen+Shot+2015-10-08+at+10.05.50+PM.png "Screen Shot 2015-10-08 at 10.05.50 PM.png")

After configuring for plugins, we have to set the default new user have the permission to create posts by setting up the default new user as "Author". Click "Settings", then "General", as:
![enter image description here](https://lh3.googleusercontent.com/-EFUC7X-J8UQ/VhdMR65Ge-I/AAAAAAAADqA/gPaCGoOCUs8/s600/Screen+Shot+2015-10-08+at+10.08.45+PM.png "Screen Shot 2015-10-08 at 10.08.45 PM.png")

Change the "New User Default Role" to "Author":

![enter image description here](https://lh3.googleusercontent.com/-CjmyYO739HU/VhdMcIpp51I/AAAAAAAADqM/wtYN5moXL58/s600/Screen+Shot+2015-10-08+at+10.08.57+PM.png "Screen Shot 2015-10-08 at 10.08.57 PM.png")

Don't forget click the button at the bottom of the page to "Save Changes".

### Verify the connections

We need several test cases to verify the connections, basically, just write the test cases, then run them automatically. For simplifying the validation process, I created a repository for the test cases, and leverage Jasmine as the test framework, you have to install nodejs (please refer to my previous blog [here](http://lifuzu.com/blog/2014/08/20/install-nodejs-using-nvm/)) then Jasmine-node globally, as:

```
$ npm install jasmine-node -g
```
Clone the automation test repository from github:
```
$ git clone https://github.com/lifuzu/capstone4tipcalc.git
```

Enter the `tests` folder, run the test cases: 
```
$ cd environment/restapi/tests/
$ jasmine-node .
......

Finished in 0.88 seconds
6 tests, 33 assertions, 0 failures, 0 skipped
```
If you experience any failure, probably you have to modify the file `automation_spec.js` to your IP address which is different on different host.

You should find some new user created by clicking "Users" from the left sidemenu, as:
![enter image description here](https://lh3.googleusercontent.com/-uKNnL1E3jvg/VhdRVZd9HnI/AAAAAAAADrE/Uyl3W_fodRY/s600/Screen+Shot+2015-10-08+at+10.31.07+PM.png "Screen Shot 2015-10-08 at 10.31.07 PM.png")

And new posts by clicking the "Posts" from the left sidemenu:
![enter image description here](https://lh3.googleusercontent.com/-aF-czcMgyL4/VhdRiA1T14I/AAAAAAAADrU/DjxRm6WzuFw/s600/Screen+Shot+2015-10-08+at+10.31.27+PM.png "Screen Shot 2015-10-08 at 10.31.27 PM.png")

Or home page here `http://192.168.99.100:8080/`, as:
![enter image description here](https://lh3.googleusercontent.com/-wBYkoqqe6Do/VhdSC-QfCZI/AAAAAAAADrg/3eiS0W50IXM/s600/Screen+Shot+2015-10-08+at+10.34.31+PM.png "Screen Shot 2015-10-08 at 10.34.31 PM.png")

### References
1. https://wordpress.org/plugins/json-api/
2. https://wordpress.org/plugins/json-api-user/
3. https://github.com/lifuzu/capstone4tipcalc.git

> Written with [StackEdit](https://stackedit.io/).
