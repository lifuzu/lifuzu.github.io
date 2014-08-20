---
layout: post
title: "Install Nodejs Using NVM"
date: 2014-08-20 11:44:12 -0700
comments: true
categories: nodejs, npm, nvm, Ubuntu
---

![enter image description here][1]

An alternative to installing Node.js through apt is to use a specially designed tool called nvm, which stands for "Node.js version manager".

Using nvm, you can install multiple, self-contained versions of Node.js which will allow you to control your environment easier. It will give you on-demand access to the newest versions of Node.js, but will also allow you to target previous releases that your app may depend on.
<!-- more -->
### Install prerequisite package
To start off, we'll need to get the software packages from our Ubuntu repositories that will allow us to build source packages. The nvm script will leverage these tools to build the necessary components:
```
sudo apt-get update
sudo apt-get install build-essential libssl-dev
```
### Install nvm
Once the prerequisite packages are installed, you can pull down the nvm installation script from the project's GitHub page. The version number may be different, but in general, you can download and install it with the following syntax:
```
curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
```
This will download the script and run it. It will install the software into a subdirectory of your home directory at ~/.nvm. It will also add the necessary lines to your ~/.profile file to use the file.

To gain access to the nvm functionality, you'll need to log out and log back in again, or you can source the ~/.profile file so that your current session knows about the changes:
```
source ~/.profile
```
Now that you have nvm installed, you can install isolated Node.js versions.

### Install nodejs
To find out the versions of Node.js that are available for installation, you can type:
```
nvm ls-remote
. . .
 v0.11.6
 v0.11.7
 v0.11.8
 v0.11.9
v0.11.10
v0.11.11
v0.11.12
v0.11.13
```
As you can see, the newest version at the time of this writing is v0.11.13. You can install that by typing:
```
nvm install 0.11.13
```
Usually, nvm will switch to use the most recently installed version. You can explicitly tell nvm to use the version we just downloaded by typing:
```
nvm use 0.11.13
```
When you install Node.js using nvm, the executable is called node. You can see the version currently being used by the shell by typing:
```
$ node -v
v.0.11.13
$ npm -v
1.4.9
```
If you have multiple Node.js versions, you can see what is installed by typing:
```
$ nvm ls
->  v0.11.13
      system
```
If you wish to default one of the versions, you can type:
```
$ nvm alias default 0.11.13
```
This version will be automatically selected when a new session spawns. You can also reference it by the alias like this:
```
$ nvm use default
```
Each version of Node.js will keep track of its own packages and has npm available to manage these.
### Install nodejs packages with npm
You can have npm install packages to the Node.js project's ./node_modules directory by using the normal format:
```
$ npm install express
```
If you'd like to install it globally (available to the other projects using the same Node.js version), you can add the -g flag:
```
$ npm install -g express
```
This will install the package in:
```
~/.nvm/node_version/lib/node_modules/package_name
```
Installing globally will let you run the commands from the command line, but you'll have to use link the package into your local sphere to require it from within a program:
```
npm link express
```
You can learn more about the options available to you with nvm by typing:
```
nvm help
```
> Written with [StackEdit](https://stackedit.io/).

### Reference:
1. https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

  [1]: https://lh3.googleusercontent.com/-1_vzgrh5dnI/U_Tq8koEceI/AAAAAAAACYA/S8xhWfrGSoE/s600/Screen+Shot+2014-08-20+at+11.36.59+AM.png "Screen Shot 2014-08-20 at 11.36.59 AM.png"
