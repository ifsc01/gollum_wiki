# deploy gollum	 

## tools

* foreman
* systemd 


```bash
sudo apt-get install make build-essential ruby ruby-dev libicu-dev
```

```bash
gem install bundler
```

```bash
bundle install --path vendor
```

foreman 

```bash
sudo bundle exec foreman export -u root -a gollum systemd /etc/systemd/system
```
 重新加载配置文件
```bash
sudo systemctl daemon-reload
```

