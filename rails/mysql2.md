
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


```
gem install mysql2 -v '0.5.2' -- --srcdir=/usr/local/include/mysql/
```