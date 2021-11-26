---
layout: post
title: "Playing with Ansible to manage build pool"
date: 2016-03-06 23:30:26 -0800
comments: true
categories: Ansible Xcode
---
### Ansible
![Ansible](https://lh3.googleusercontent.com/-5avk7kTPus4/Vt0q8cKjYhI/AAAAAAAAEBU/3hJt7LybC-w/s600/ansible.png "ansible.png")

Ansible is one of the best configuration management system, together with Puppet, Chef, and etc. Ansible makes IT deployment automatic and easy. With Ansible, deploying application, managing systems is becoming easier than ever, as well as building a strong foundation for DevOps.

This article use Ansible to config and manage Xcode build pool step by step.
<!-- more -->
### Install ansible on Ubuntu
```
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
```
### Install brew on Mac OS X server
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
### Install ansible on all of the server
```
$ brew install ansible
```
### Connect all clients from a machine (called controller) which you are using to control all clients
```
$ ssh-genkey -t rsa -b 2048
$ ssh-copy-id <client_username>@<client_server_address>
```
for example (for every client):
```
$ ssh-copy-id admin@imac-1.local
```
### Create hosts document under `/etc/ansible/hosts` on the controller
```
[office:vars]
admin_user=admin

[sandbox]
imac-1.local

[office]
imac-1.local
imac-2.local
```
### Config scp over ssh `/etc/ansible/ansible.cfg` (ref #3)
```
[ssh_connection]
scp_if_ssh=True
```
### Try to connect all of the clients
```
$ ansible -i hosts ubuntuservers -m ping -u build # specify hosts file
# OR
$ ansible all -m ping -u admin
imac-1.local | success >> {
    "changed": false, 
    "ping": "pong"
}

imac-2.local | success >> {
    "changed": false, 
    "ping": "pong"
}
```
cool, looks good for now!
### Create a playbook named `hello-ansible.yml` under the current folder
```
---
- hosts: all
  remote_user: admin
  gather_facts: False
  tasks:
    - name: print to stdout
      command: echo "Hello"
      register: hello

    - debug: msg="{{ hello }}"

    - name: print Java version
      shell: "java -version 2>&1"
      register: java_version

    - debug: msg="{{ java_version.stdout_lines }}"
```
### Run the playbook we created above
```
$ ansible-playbook hello-ansible.yml
```
It should print a lot of outputs, including:
```
...
TASK: [debug msg="{{hello}}"] ************************************************* 
ok: [imac-1.local] => {
    "msg": "{u'changed': True, u'end': u'2015-10-22 14:21:08.740247', u'stdout': u'Hello', u'cmd': [u'echo', u'Hello'], u'start': u'2015-10-22 14:21:08.734848', u'delta': u'0:00:00.005399', u'stderr': u'', u'rc': 0, 'invocation': {'module_name': 'command', 'module_args': 'echo Hello'}, 'stdout_lines': [u'Hello']}"
}
ok: [imac-2.local] => {
    "msg": "{u'changed': True, u'end': u'2015-10-22 14:21:08.742023', u'stdout': u'Hello', u'cmd': [u'echo', u'Hello'], u'start': u'2015-10-22 14:21:08.736217', u'delta': u'0:00:00.005806', u'stderr': u'', u'rc': 0, 'invocation': {'module_name': 'command', 'module_args': 'echo Hello'}, 'stdout_lines': [u'Hello']}"
}
...
TASK: [debug msg="{{java_version.stdout_lines}}"] ***************************** 
ok: [imac-1.local] => {
    "msg": "[u'java version 1.8.0_45', u'Java(TM) SE Runtime Environment (build 1.8.0_45-b14)', u'Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)']"
}
ok: [imac-2.local] => {
    "msg": "[u'java version 1.8.0_45', u'Java(TM) SE Runtime Environment (build 1.8.0_45-b14)', u'Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)']"
}
...
```
OR
```
$ ansible-playbook -i hosts macports.yaml -K
```
`-i` specify hosts file, and `-K` ask for sudo password.

### Create a git repo to store the playbooks
```
$ git init .
$ git add .
$ git config --global user.email "<your@email.address>"
$ git config --global user.name "<Your Name>"
$ git commit
$ git remote add origin <git_repo>
$ git push origin master
```
OK, we start to figure out how to manage Xcode from now.
### Create a playbook for xcode-install
```
---
- hosts: all
  remote_user: jenkins-admin
  gather_facts: False
  tasks:
    - name: install xcode-install
      gem:  name=xcode-install state=present
```
name it as `xcode-install.yaml`

TODO:
```
$ softwareupdate -l
$ softwareupdate -i -a
$ xcode-install list
$ xcode-install install 7.1
$ ...
```

### Reuse the shared module, Ansible call it `Role` (ref #4)
"Roles in Ansible build on the idea of include files and combine them to form clean, reusable abstractions – they allow you to focus more on the big picture and only dive down into the details when needed."
```
$ sudo ansible-galaxy install smola.java  # see readme at ref #5
```
then create playbook `java.yml` with the following content:
```
---
- hosts: ubuntuservers
  remote_user: build
  sudo: True
  vars:
    java_packages:
      - oracle-java6-installer
      - oracle-java6-set-default

  roles:
    - { role: smola.java }
```
run the command:
```
$ ansible-playbook -i hosts java.yml
```


### References:
1. http://brew.sh/
2. https://github.com/ideasonpurpose/ansible-playbooks
3. http://stackoverflow.com/questions/23899028/ansible-failed-to-transfer-file-to
4. http://docs.ansible.com/ansible/playbooks_roles.html
5. https://github.com/smola/ansible-java-role

> Written with [StackEdit](https://stackedit.io/).
