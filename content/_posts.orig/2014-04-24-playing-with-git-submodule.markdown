---
layout: post
title: "Playing with git submodule"
date: 2014-04-24 22:01:03 -0700
comments: true
categories: 
---
![enter image description here][1]
### Intructions:
- add a submodule
```bash
$ git submodule add -b BRANCH ssh://REPO_URL/REPO_PATH SUBMODULE_PATH
$ git commit -m "add a submodule at SUBMODULE_PATH"
```
- clone the project with submodule(s)
```
$ git clone ssh://REPO_URL/REPO_PATH PROJECT
cd PROJECT
$ git submodule update --init --rebase
```
- get submodule status
```bash
$ git submodule status
$ git submodule foreach git branch -a
```
- checkout all submodule to a branch defined in .gitmodule (which means we specify the branch when we add the submodule with '-b BRANCH')
```bash
$ git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'
# OR a short version
$ git submodule foreach git checkout master
```
- pull the latest master for all of the submodule
```
$ git submodule -q foreach git pull -q origin master
```
- develop in submodule
```
# Make your changes in submoduleA
$ cd submoduleA
$ git add .
$ git commit -m "Updated the submoduleA"
$ git push origin BRANCH
```
- sync to project
```
$ cd PROJECT
$ git pull
$ git submodule update --rebase
```
- manually update the project to track submodule (Gerrit submodule description commit the track automatically)
```
$ cd PROJECT
$ git add submoduleA
$ git commit -m "Updated submodule a."
$ git push origin BRANCH_NAME
```
- deinit, and remove a submodule
```
$ git submodule deinit SUBMODULE_PATH
$ git rm SUBMODULE_PATH
$ git commit -m "remove the submodule at SUBMODULE_PATH"
```

### References:
1. http://git-scm.com/docs/git-submodule
2. http://git-scm.com/docs/git-rm.html
3. http://stackoverflow.com/questions/8642668/how-to-make-submodule-with-detached-head-to-be-attached-to-actual-head
4. http://www.vogella.com/tutorials/Git/article.html#submodules

> Written with [StackEdit](https://stackedit.io/).


  [1]: https://lh4.googleusercontent.com/-GW4P0d8zZdM/U1nrsDaCgiI/AAAAAAAAB5I/4mTt3xjfmFo/s0/xlotte-git.jpg "xlotte-git.jpg"
