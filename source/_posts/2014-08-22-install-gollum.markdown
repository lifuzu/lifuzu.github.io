---
layout: post
title: "Install Gollum"
date: 2014-08-22 11:57:46 -0700
comments: true
categories: Ruby, Gollum, Git, Wiki
---

![gollum snapshot](https://lh4.googleusercontent.com/-DUpioC7fb_I/U_eSdHggv1I/AAAAAAAACYU/4VJAsLqqCSE/s600/Screen+Shot+2014-08-22+at+11.56.27+AM.png "Screen Shot 2014-08-22 at 11.56.27 AM.png")

Gollum is a simple wiki system built on top of Git.

Gollum wikis are simply Git repositories that adhere to a specific format. Gollum pages may be written in a variety of formats and can be edited in a number of ways depending on your needs. You can edit your wiki locally:

- With your favorite text editor or IDE (changes will be visible after committing).
- With the built-in web interface.
- With the Gollum Ruby API.

Here are steps to install gollum.
<!-- more -->

### Install some dependencies:
```
sudo apt-get install libicu-dev
```
### Install Gollum with RubyGems:
```
gem install gollum
```
### Install some text format
```
gem install redcarpet
gem install github-markdown
```
### Create a local git repo on host
```
mkdir repos/gollum
cd repos/gollum
git init .
```
### Run the gollum
```
gollum
```
This will start up a web server running the Gollum frontend and you can view and edit your wiki at http://`<host>`:4567.

### BUILDING THE GEM FROM MASTER
```
$ gem uninstall -aIx gollum
$ git clone https://github.com/gollum/gollum.git
$ cd gollum
gollum$ rake build
gollum$ gem install --no-ri --no-rdoc pkg/gollum*.gem
```
### RUN THE TESTS
```
$ bundle install
$ bundle exec rake test
```
### RUNNING WITH UPSTART
Create a wrapper to include environment information:
```
$ rvm alias create mygollum ruby-2.1.2@mygollum
$ rvm alias list
# $HOME/.rvm/wrappers/mygollum/gollum
```
Create a config file under /etc/init, name it `gollum.cong`, as:
https://gist.github.com/lifuzu/31af0dc859bf9bfb6da5
Start/Stop the service:
```
# sudo start gollum
$ sudo stop gollum
```
You can get the log file at /var/log/upstart/gollum.log to analyze:
```
$ sudo vi /var/log/upstart/gollum.log 
```
### RUNNING WITH NGINX
Create a subdomain like 'gollum.weimed.com' point to your server IP;
Create a nginx configuration file, as /etc/nginx/sites-available/stackedit.weimed.com:
https://gist.github.com/lifuzu/2f2ce9095ba4a6969b2c
Create a symbolic link to enable it
```
$ sudo ln -s /etc/nginx/sites-available/gollum.weimed.com /etc/nginx/sites-enabled/gollum.weimed.com
```
Check the configuration:
```
$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
Reload the configuration:
```
$ sudo service nginx reload
```
You should see: http://gollum.weimed.com/

### AUTH
TODO, please refer to [5], [6]

### References:
1. https://github.com/gollum/gollum
2. https://gist.github.com/leon/2643936
3. http://rvm.io/integration/init-d
4. https://github.com/rvm/rvm-site-setup/blob/master/conf/smfbot.conf
5. http://www.mfoot.com/blog/2013/05/19/setting-up-a-personal-wiki-with-aws-and-gollum/
6. https://github.com/roman/rack-auth


> Written with [StackEdit](https://stackedit.io/).
