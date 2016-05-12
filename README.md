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

Fixed a rake preview issue after upgrade to El Captain on Mac:
```sudo chown -R $(whoami) /usr/local```
Check the latest Ruby version: https://www.ruby-lang.org/en/downloads/ ```rbenv install <Latest-Ruby-Version>```
```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
``` to your ~/.bash_profile, then ```source ~/.bash_profile```
http://schalkneethling.github.io/blog/2015/10/16/errno-enoent-no-such-file-or-directory-jekyll-octopress-el-capitan/

### Basic steps
```
rake new_post["POST TITLE"]
rake generate
rake preview
rake deploy
```
