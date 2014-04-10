---
layout: post
title: "remove repository from Gerrit"
date: 2014-04-09 22:42:53 -0700
comments: true
categories: gerrit
---
![Gerrit icon][1]
### Instructions:
*1*. Move the repository folder on server:
```bash
# on gerrit server
$ cd $site_path/git; 
$ mv old_name.git new_name.git 
```

*2*. Flush the caches on server:
```bash
# On another client image:
$ ssh -p 29418 gerrit.server.com gerrit flush-caches
```

*3*. Run sql statement to update the changes:
```bash
# On another client image (need "Access Database" capability):
$ ssh -p 29418 gerrit.server.com gerrit gsql [Enter]
gerrit> USE {Database};
gerrit> SELECT * FROM changes WHERE dest_project_name = 'old_name';
# if have more than 1, run the following command to update, otherwise, quit with \q;
gerrit> UPDATE changes SET dest_project_name = 'new_name' WHERE 
dest_project_name = 'old_name';
gerrit> \q
```

### References:
1. https://groups.google.com/forum/#!topic/repo-discuss/ltIxBipUPKI


> Written with [StackEdit](https://stackedit.io/).


  [1]: https://lh4.googleusercontent.com/-_03bVFvmzzg/U0YvHJPBLCI/AAAAAAAAB4M/SSKXyOR_T3U/s0/diffymute-300x279.png "diffymute-300x279.png"
