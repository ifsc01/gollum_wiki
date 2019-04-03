fix Failed to build gem native extension

```
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    current directory: /Users/lidashuang/.rbenv/versions/2.5.5/lib/ruby/gems/2.5.0/gems/mysql2-0.5.2/ext/mysql2
/Users/lidashuang/.rbenv/versions/2.5.5/bin/ruby -r ./siteconf20190403-56466-vatazj.rb extconf.rb
checking for rb_absint_size()... yes
checking for rb_absint_singlebit_p()... yes
checking for rb_wait_for_single_fd()... yes
-----
Using mysql_config at /usr/local/bin/mysql_config
```

https://qiita.com/HrsUed/items/ca2e0aee6a2402571cf6

```
gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib
```