---
layout: post
title: "Playing with Gerrit Jira plugin"
date: 2014-08-05 11:05:16 -0700
comments: true
categories: 
---
![Gerrit][1]
###Build and Setup
**1**. Clone the Gerrit source:
``` bash
$ git clone https://gerrit.googlesource.com/gerrit
```
**2**. Checkout to version 2.8 (2.8 is the latest stable version), include to update submodules:
``` bash
$ cd gerrit
$ git checkout -b stable-2.8 stable-2.8
$ git submodule update --init --rebase # commands, please referece to git submodule
```
**3**. Clone buck, buck is the build system for the latest Gerrit, then build it with ant ('sudo apt-get install ant'):
``` bash
$ git clone https://gerrit.googlesource.com/buck
$ cd buck
$ ant
```
**4**. Install buck to be accessed globally:
``` bash
$ mkdir ~/bin
$ export PATH=~/bin:$PATH
$ ln -s `pwd`/bin/buck ~/bin/
$ ln -s `pwd`/bin/buckd ~/bin/
$ which buck
```
**5**. Build Gerrit:
``` bash
$ cd gerrit
$ buck build gerrit
```
>**NOTE:** The gerrit.war will be generated here: buck-out/gen/gerrit.war

**6**. Build extension, plugin, GWT API jar files, and install them:
``` bash
$ buck build api
$ buck build api_install
```
**7**. Build all core plugins (optional):
``` bash
$ buck build plugins:core
```
> **NOTE:** All core plugins will be generated here: buck-out/gen/plugins/&lt;name&gt;/&lt;name&gt;.jar

**8**. Clone the hooks-its, and hooks-jira projects:
``` bash
$ git clone https://gerrit.googlesource.com/plugins/hooks-its plugins/hooks-its
$ cd plugins/hooks-its
$ git checkout -b v2.8 origin/stable-2.8
$ cd ../..
$ git clone https://gerrit.googlesource.com/plugins/hooks-jira plugins/hooks-jira
```

**9**. Modify the pom.xml files under plugins/hooks-its AND plugins/hooks-its/hooks-its:
``` bash
cd plugins/hooks-its
$ git diff
diff --git a/hooks-its/pom.xml b/hooks-its/pom.xml
index a206459..75e11dc 100644
--- a/hooks-its/pom.xml
+++ b/hooks-its/pom.xml
@@ -22,7 +22,7 @@ limitations under the License.
   <parent>
     <groupId>com.googlesource.gerrit.plugins.its</groupId>
     <artifactId>hooks-its-parent</artifactId>
-    <version>2.9-SNAPSHOT</version>
+    <version>2.8</version>
   </parent>
   <artifactId>hooks-its</artifactId>
   <name>Gerrit Code Review - Commit validation and Workflow</name>
diff --git a/pom.xml b/pom.xml
index 600bff9..995d008 100644
--- a/pom.xml
+++ b/pom.xml
@@ -22,7 +22,7 @@ limitations under the License.
   <groupId>com.googlesource.gerrit.plugins.its</groupId>
   <artifactId>hooks-its-parent</artifactId>
   <packaging>pom</packaging>
-  <version>2.9-SNAPSHOT</version>
+  <version>2.8</version>
 
   <name>Gerrit Code Review - Issue tracker support</name>
```
**10**. Build the hooks-its:
``` bash
$ cd plugins/hooks-its
$ mvn -DskipTests -Dmaven.test.skip=true package install
```
> **NOTE:** The hooks-its-2.8.jar will be generated here: hooks-its/target/hooks-its-2.8.jar
> **NOTE**: If don't skip tests, run with the command: `mvn clean package install`, then will fail on test case!
> **NOTE**: Gerrit select BUCK as its new build system, for new plugin, please reference to the following *NOTES* #5

**11**. Modify the pom.xml files under plugins/hooks-jira:
``` bash
$ cd plugins/hooks-jira
$ git diff
diff --git a/pom.xml b/pom.xml
index 7b04c60..8f60c78 100644
--- a/pom.xml
+++ b/pom.xml
@@ -20,7 +20,7 @@ limitations under the License.
   <parent>
     <groupId>com.googlesource.gerrit.plugins.its</groupId>
     <artifactId>hooks-its-parent</artifactId>
-    <version>2.9-SNAPSHOT</version>
+    <version>2.8</version>
   </parent>
   <artifactId>hooks-jira</artifactId>
   <packaging>jar</packaging>
```
**12**. Build the hooks-jira:
``` bash
$ cd plugins/hooks-jira
$ mvn clean package
```
> **NOTE:** The hooks-jira-2.8.jar will be generated here: target/hooks-jira-2.8.jar

**13**. Copy the following jar files to the `plugin` folder under the Gerrit installation path on remote server:
``` bash
hooks-its-2.8.jar
hooks-jira-2.8.jar
```
For example:
```
$ scp hooks-its/target/hooks-its-2.8.jar ../hooks-jira/target/hooks-jira-2.8.jar gerrit2@review.example.co:/home/gerrit2/review_site/plugins
```
**14**. Add a new file etc/its/action.config under the Gerrit installation path on remote server:
``` bash
[rule "merged"]
        event-type = change-merged
        action = add-standard-comment
[rule "comment"]
        event-type = comment-added
        action = add-standard-comment
[rule "patch-set"]
        event-type = patchset-created
        action = add-standard-comment
[rule "ref-updated"]
        event-type = ref-updated
        action = add-standard-comment
```
**15**. Run the Gerrit initial installation command on remote server:
``` bash
$ java -jar gerrit-2.8.war init -d review_site

*** Gerrit Code Review 2.8
***


*** Git Repositories
***

Location of Git repositories   [git]:

*** SQL Database
***

Database server type           [mysql]:
Server hostname                [localhost]:
Server port                    [(mysql default)]:
Database name                  [reviewdb]:
Database username              [gerrit2]:
Change gerrit2's password      [y/N]?

*** User Authentication
***

Authentication method          [DEVELOPMENT_BECOME_ANY_ACCOUNT/?]:

*** Email Delivery
***

SMTP server hostname           [localhost]:
SMTP server port               [(default)]:
SMTP encryption                [NONE/?]:
SMTP username                  [gerrit2]:
Change gerrit2's password      [y/N]?

*** Container Process
***

Run as                         [gerrit2]:
Java runtime                   [C:\Program Files (x86)\Java\jre7]:
Upgrade c:\Users\gerrit2\gerrit\bin\gerrit.war [Y/n]?
Copying gerrit-2.8.war to c:\Users\gerrit2\gerrit\bin\gerrit.war

*** SSH Daemon
***

Listen on address              [*]:
Listen on port                 [29418]:

*** HTTP Daemon
***

Behind reverse proxy           [y/N]?
Use SSL (https://)             [y/N]?
Listen on address              [*]:
Listen on port                 [8080]:
Canonical URL                  [http://review.example.com:8080/]:

*** Plugins
***

Install plugin reviewnotes version v2.8 [y/N]?
Install plugin download-commands version v2.8 [y/N]?
Install plugin replication version v2.8 [y/N]?
Install plugin commit-message-length-validator version v2.8 [y/N]?


*** Jira connectivity
***

Jira URL (empty to skip)       [https://jira.example.com/]:
Jira username                  [jira-robot]:
Change jira-robot's password        [y/N]?
Test connectivity to https://jira.example.com [y/N]? y
Checking Jira connectivity ... [OK]

*** Jira issue-tracking association
***

Jira issue-Id regex            [([A-Z]+-[0-9]+)]:
Issue-id enforced in commit message [MANDATORY/?]:?
Supported options are:
           mandatory
           suggested
           optional
Issue-id enforced in commit message [MANDATORY/?]: suggested
Initialized C:\Users\gerrit2\gerrit
```
**16**. Restart gerrit-jetty service:
``` bash
$ sudo service gerrit-jetty.sh restart
```
**17**. Done!

### NOTES:
*1*. Download Gerrit here: http://gerrit-releases.storage.googleapis.com/index.html

*2*. The file review_site/etc/gerrit.config should look like:
```
[jira]
        url = http://review.example.com:8080
        username = jira-robot
        commentOnRefUpdatedGitWeb = false   # to comment gitweb comments on jira
[commentLink "jira"]
        match = ([A-Z]+-[0-9]+)
        html = <a href=\"http://jira.example.com:8080/browse/$1\">$1</a>
        association = SUGGESTED
```
*3*. If we just want to parse the jira id on the subject of the git comments, then here is the diff:
```
diff --git a/hooks-its/src/main/java/com/googlesource/gerrit/plugins/hooks/util/
index a04b175..3d56426 100644
--- a/hooks-its/src/main/java/com/googlesource/gerrit/plugins/hooks/util/CommitM
+++ b/hooks-its/src/main/java/com/googlesource/gerrit/plugins/hooks/util/CommitM
@@ -31,7 +31,7 @@ public class CommitMessageFetcher {
       RevWalk revWalk = new RevWalk(repo);
       RevCommit commit = revWalk.parseCommit(ObjectId.fromString(commitId));
 
-      return commit.getFullMessage();
+      return commit.getShortMessage();
     } finally {
       repo.close();
     }
```
*4*. Get the log message from jetty/logs on Gerrit server.
*5*. Gerrit choose BUCK as its new build system, so for the new plugin, the build steps should be (take cookbook-plugin as an example):
```
buck build plugins/cookbook-plugin
```
The output is created in: buck-out/gen/plugins/cookbook-plugin/cookbook-plugin.jar


### References:
*1*. https://groups.google.com/forum/#!msg/repo-discuss/GSyHMeaCyyw/cJGunFcNc4oJ
*2*. https://gerrit-review.googlesource.com/Documentation/dev-buck.html

> Written with [StackEdit](https://stackedit.io/).


  [1]: https://lh5.googleusercontent.com/dDJ6IKUAZN5IZMlt8CmQic457z5BKfJ4WdqXrH2sf5s=s650 "Gerrit"
