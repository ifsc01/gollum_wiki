## collate 

change table collate

```
ALTER TABLE admins CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

database



## utf8mb4

```
CREATE SCHEMA `laiwang_dev` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
```

column 

```
ALTER TABLE `laiwang_staging`.`admins` 
CHANGE COLUMN `username` `username` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL ;
```

links

- [mysql大小写敏感与校对规则 - 天士梦 - 博客园](https://www.cnblogs.com/cchust/p/3952821.html)
- [MySQL查询对大小写不敏感 - 简书](https://www.jianshu.com/p/408daf82ac71)
- [再见乱码：5分钟读懂MySQL字符集设置 - 程序猿小卡 - 博客园](https://www.cnblogs.com/chyingp/p/mysql-character-set-collation.html)
- [mysql大小写敏感与校对规则 - 天士梦 - 博客园](https://www.cnblogs.com/cchust/p/3952821.html)


- [MYSQL中的COLLATE是什么？ - 掘金](https://juejin.im/post/5bfe5cc36fb9a04a082161c2)
- [mysql使用utf8mb4经验吐血总结 | Sean's Notes](http://seanlook.com/2016/10/23/mysql-utf8mb4/)
- [修改MySQL的字符集为utf8mb4 | Polar Snow Documentation](https://docs.lvrui.io/2016/08/21/%E4%BF%AE%E6%94%B9MySQL%E7%9A%84%E5%AD%97%E7%AC%A6%E9%9B%86%E4%B8%BAutf8mb4/)


