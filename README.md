lifuzu.github.io

blog

### Preparation
```
checkout source
sudo gems install bundler
bundler install
```
### Clone a deploy folder:
```
$ git clone https://github.com/lifuzu/lifuzu.github.io.git _deploy
```

And fixed a version issue according to: http://johnmorales.com/blog/2014/01/06/octopress-you-have-already-activated-rake-but-your-gemfile-requires-rake-dot-dot-dot-prepending-bundler-exec-needs-a-command-to-run-to-your-command-may-solve-this/

Fixed a Gist plugin issue according to: https://github.com/imathis/octopress/pull/1506

### Basic steps
```
rake new_post["POST TITLE"]
rake generate
rake preview
rake deploy
```
