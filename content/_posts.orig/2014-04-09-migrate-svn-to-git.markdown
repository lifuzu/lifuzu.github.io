---
layout: post
title: "migrate svn to git"
date: 2014-04-09 22:21:27 -0700
comments: true
categories: svn git
---
![migrate svn to git][1]
###Instructions:
*1*. Check out the source tree from SVN server with svn command:
```bash
svn co http://my-project.googlecode.com/svn/trunk
```
*2*. Generate an users.txt with the command:
```bash
$ svn log ^/ --xml | grep -P "^<author" | sort -u | \
      perl -pe 's/<author>(.*?)<\/author>/$1 = /' > users.txt
```
   and following the formatting:
```text
schacon = Scott Chacon <schacon@geemail.com>
selse = Someo Nelse <selse@geemail.com>
```
**NOTE**: You can try the script to generate authors list automatically: [https://gist.github.com/lifuzu/9081923#file-findauthors-sh][2]

*3*. Once the users.txt is ready, then checkout the source tree again with the command 'git svn clone':
```bash
$ git svn clone http://my-project.googlecode.com/svn/ \
      --authors-file=users.txt --no-metadata -s my_project
```
*4*. To move the tags to be proper Git tags, run:
```bash
$ git for-each-ref refs/remotes/tags | cut -d / -f 4- | grep -v @ | while read tagname; do git tag "$tagname" "tags/$tagname"; git branch -r -d "tags/$tagname"; done
```
*5*. To move the rest of the references under refs/remotes to be local branches:
```bash
$ git for-each-ref refs/remotes | cut -d / -f 3- | grep -v @ | while read branchname; do git branch "$branchname" "refs/remotes/$branchname"; git branch -r -d "$branchname"; done
```
*6*. Adding the git server as a remote:
```bash
$ git remote add origin git@my-git-server:myrepository.git
```
*7*. Push all your branches and tags to go up:
```bash
$ git push origin --all
$ git push origin --tags
```
*8*. Update the changes from SVN (before you update, please cleanup your local workspace)
```bash
$ git svn fetch
...
r81152 = c2465633b56d16081334336ee87d506b97d10449 (refs/remotes/git-svn)
$ git checkout master
$ git merge remotes/git-svn
```
**NOTE**: Sometimes when you run `git svn fetch`:
```
...
r81217 = eb79c770f852f6158a583bb17a8c1a326f7b4e03 (refs/remotes/trunk)
```
Then you need to run:
```
$ git checkout master
$ git merge remotes/trunk
```
*9*. Then check them into GIT
```bash
$ git log # should have some changes merged from SVN
$ git push origin master
```
*10*. If you have a temporary migration branch you modified something on that, then you need rebase the changes on master to migration:
```bash
$ git checkout migration
$ git rebase master  # fix the conflicts if have
```
*11*. Finally, you need merge the changes on migration, fast forward, since you have rebased.
```bash
$ git checkout master
$ git merge migration
```

That is it!

###Reference:
1. http://git-scm.com/book/en/Git-and-Other-Systems-Migrating-to-Git
2. http://git-scm.com/book/ch3-6.html
3. http://stackoverflow.com/questions/16565991/keep-svn-repository-in-sync-with-git-one
4. http://stackoverflow.com/questions/5241898/is-a-bidrectional-git-svn-sync-both-writable-possible

> Written with [StackEdit](https://stackedit.io/).


  [1]: https://lh6.googleusercontent.com/-zWvC0T4xLUM/U0YqARAy3HI/AAAAAAAAB34/N0PazinANn0/s0/svn_to_git-860x200.png "svn_to_git-860x200.png"
  [2]: https://gist.github.com/lifuzu/9081923#file-findauthors-sh
