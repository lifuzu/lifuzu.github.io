---
layout: post
title: "playing with Jenkins create job"
date: 2014-04-24 22:08:09 -0700
comments: true
categories: 
---
![Jenkins logo][1]
## create new job from templates
In this article, we will talk about how to create a Jenkins job with a template by some commands.

### Instructions
*1*. Get the Jenkins CLI client package
```
$ wget http://jenkins/jnlpJars/jenkins-cli.jar
```
*2*. Check which commands supported by the client package [Exception *1*,*2*]
```
$ java -jar jenkins-cli.jar -s http://jenkins/ help
```
*3*. List all jobs under the view: tools
```
$ java -jar jenkins-cli.jar -s http://jenkins/ list-jobs tools
```

*4*. Get the configuration of the job: template
```
$ java -jar jenkins-cli.jar -s http://jenkins/ get-job template > template.xml
```
*5*. Create a new job based on the configuration
```
$ java -jar jenkins-cli.jar -s http://jenkins/ create-job new_job_name < new_job_name.xml
```
*6*. Run groovy script
```
$ java -jar jenkins-cli.jar -s http://jenkins/ groovy scripts/add_job_to_view.groovy
```
If there are any parameters in the script, just as:
```
import jenkins.model.*

if (args.length != 2 ) {
  println "Error on arguments!"
}
def jobName  = args[0] ?: 'a_job'
def viewName = args[1] ?: 'a_view'

println jobName + ' ' + viewName

def v = Jenkins.instance.getView(viewName)
def i = Jenkins.instance.getItemByFullName(jobName)
if (v && i) {
  v.add(i)
}
```
pass the parameters as:
```
$ java -jar jenkins-cli.jar -s http://jenkins/ groovy scripts/add_job_to_view.groovy JOB_NAME VIEM_NAME
```
*7*. Build a job
```
$ java -jar jenkins-cli.jar -s http://jenkins/ build new_job_name
```
*8*. Diable a job
```
$ java -jar jenkins-cli.jar -s http://jenkins/ disable-job new_job_name
```

### Exceptions:
*1*. Description:
```
Exception in thread "main" java.io.IOException: No X-Jenkins-CLI2-Port among [null, Vary, Date, Content-Length, Keep-Alive, Set-Cookie, Connection, Content-Type, X-Powered-By, Server]
	at hudson.cli.CLI.getCliTcpPort(CLI.java:281)
	at hudson.cli.CLI.<init>(CLI.java:128)
	at hudson.cli.CLIConnectionFactory.connect(CLIConnectionFactory.java:72)
	at hudson.cli.CLI._main(CLI.java:449)
	at hudson.cli.CLI.main(CLI.java:378)
	Suppressed: java.io.EOFException: unexpected stream termination
		at hudson.remoting.ClassicCommandTransport.create(ClassicCommandTransport.java:100)
		at hudson.remoting.Channel.<init>(Channel.java:392)
		at hudson.remoting.Channel.<init>(Channel.java:388)
		at hudson.remoting.Channel.<init>(Channel.java:349)
		at hudson.remoting.Channel.<init>(Channel.java:345)
		at hudson.remoting.Channel.<init>(Channel.java:333)
		at hudson.cli.CLI.connectViaHttp(CLI.java:159)
		at hudson.cli.CLI.<init>(CLI.java:132)
		... 3 more
```
#### Solution: check the port which Jenkins is running on, put 8080 on URL should fix, just as:
```
$ java -jar jenkins-cli.jar -s http://jenkins:8080/ help
```
*2*. Description:
```
Failed to authenticate with your SSH keys.
hudson.security.AccessDeniedException2: anonymous is missing the ExtendedRead permission
	at hudson.security.ACL.checkPermission(ACL.java:54)
	at hudson.model.AbstractItem.checkPermission(AbstractItem.java:441)
	at hudson.cli.GetJobCommand.run(GetJobCommand.java:46)
	at hudson.cli.CLICommand.main(CLICommand.java:229)
	at hudson.cli.CliManagerImpl.main(CliManagerImpl.java:92)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:616)
	at hudson.remoting.RemoteInvocationHandler$RPCRequest.perform(RemoteInvocationHandler.java:275)
	at hudson.remoting.RemoteInvocationHandler$RPCRequest.call(RemoteInvocationHandler.java:256)
	at hudson.remoting.RemoteInvocationHandler$RPCRequest.call(RemoteInvocationHandler.java:215)
	at hudson.remoting.UserRequest.perform(UserRequest.java:118)
	at hudson.remoting.UserRequest.perform(UserRequest.java:48)
	at hudson.remoting.Request$2.run(Request.java:326)
	at hudson.remoting.InterceptingExecutorService$1.call(InterceptingExecutorService.java:72)
	at hudson.cli.CliManagerImpl$1.call(CliManagerImpl.java:63)
	at hudson.remoting.InterceptingExecutorService$2.call(InterceptingExecutorService.java:95)
	at java.util.concurrent.FutureTask$Sync.innerRun(FutureTask.java:334)
	at java.util.concurrent.FutureTask.run(FutureTask.java:166)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603)
	at java.lang.Thread.run(Thread.java:679)
```
```
#### Solution: add client public ssh key to the Jenkins server at: `http://jenkins/user/USERNAME/configure` | `SSH Public Keys`.

### References:
1. http://www.blackpepper.co.uk/generating-new-jenkins-jobs-from-templates-and-parameterised-builds/
2. http://javadoc.jenkins-ci.org/jenkins/model/Jenkins.html
3. https://github.com/jenkinsci/jenkins

> Written with [StackEdit](https://stackedit.io/).


  [1]: https://lh4.googleusercontent.com/-iwPM2DPUvJY/U0Y1mjJ70WI/AAAAAAAAB4g/ZOmWzMCL-_0/s0/jenkins_feature.jpg "jenkins_feature.jpg"
