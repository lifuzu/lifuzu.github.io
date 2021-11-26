---
layout: post
title: "Thoughs about alias settings in .bashrc"
date: 2014-01-13 21:24:27 -0800
comments: true
categories: 
---
Sometimes, when we install a package, just as, tomcat, we need to append some lines in .bashrc to add and export the tomcat/bin in the system PATH, then source the entire .bashrc to enable it. It is some a little risky (when you forget append $PATH, :) ) and painful, especially when we try to automate the installation process.

When we have several machines, we always need to synchronize the .bashrc file among them. I hate to copy them when I have more than 3 boxes. 

Then I have the below thoughs to simplify it, with a github repository. Of course, you don't need do these things manually again, Just try to clone the github repo at the bottom of this article.


**1**. We can create a folder, name it as:

``` bash
~/.bashrc.d/
```

> inspired by rc.d, init.d, conf.d etc;

**2**. We create some files under the folder, name them as:

``` bash
~/.bashrc.d/linux/git.alias.bash
~/.bashrc.d/linux/java.path.bash
~/.bashrc.d/linux/editor.bash
```

**3**. We add an entry point into ~/.bashrc:

``` bash
OS=$( uname | tr '[:upper:]' '[:lower:]')
if [ -d $HOME/.bashrc.d ]; then
  for SCRIPT in $( ls $HOME/.bashrc.d/${OS}/* ); do
    . ${SCRIPT}
  done
fi
```

**4**. Then we run the source command to enable them:

``` bash
source ~/.bashrc
```

**5**. Done!

Here is the repository:

[https://github.com/lifuzu/bashrc.d.git][1]

Run the command to clone it, fork it, and enjoy!

> Written with [StackEdit](https://stackedit.io/).


  [1]: https://github.com/lifuzu/bashrc.d.git
