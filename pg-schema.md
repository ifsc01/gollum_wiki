# PostgreSQL  5.7. Schemas 笔记

[https://www.postgresql.org/docs/9.4/ddl-schemas.html](https://www.postgresql.org/docs/9.4/ddl-schemas.html)

> A database contains one or more named schemas, which in turn contain tables. Schemas also contain other kinds of named objects, including data types, functions, and operators. The same object name can be used in different schemas without conflict; for example, both schema1 and myschema can contain tables named mytable. Unlike databases, schemas are not rigidly separated: a user can access objects in any of the schemas in the database he is connected to, if he has privileges to do so.

- 一个数据库包含多个schema, schema里包含tables, database 的下一层逻辑结构就是 schema
- schema 也包括各种 objects, data types, functions, operators
- 不同schem里的table名可以相同

> 在创建一个新的 database 时， PostgreSQL 会自动为其创建一个 名为 public 的 schema。 如果未设置 search_path 变量，那 么 PostgreSQL 会将你创建的所有对象默认放入 public schema 中。_

使用schema带来的好处

- 允许多用户使用一个数据库而不会相互干扰, 数据隔离
- 将数据库对象组织到逻辑组中以使其更易于管理
- 第三方应用程序可以放在单独的模式中, 这样它们就不会与其他对象的名称冲突


## 5.7.1. Creating a Schema

code example: 

```sql
CREATE SCHEMA myschema;
```

访问schema的表

```sql
schema.table
```

实际上，更通用的语法

```sql
database.schema.table
```

在schema里创建表

```sql
CREATE TABLE myschema.mytable (
 ...
);
```

删除空schema

```sql
DROP SCHEMA myschema;
```

删除schema 并且也删除其中的对象

```sql
DROP SCHEMA myschema CASCADE;
```

为某个用户创建schema

```sql
CREATE SCHEMA schemaname AUTHORIZATION username;
```

## 5.7.2. The Public Schema

默认创建的表都在`public schema`里

下面两条语句是等价的
```sql
CREATE TABLE products ( ... );
CREATE TABLE public.products ( ... );
```

## 5.7.3. The Schema Search Path

当执行类 似 `SELECT * FROM dogs` 这种语句时， PostgreSQL 是怎么知道要查的是哪个 schema 中的表 呢？

可以加schema前缀解决, 也可以设置 `search_path` 变量解决

查看 

```sql
SHOW search_path;
```

```sql
search_path
--------------
 "$user",public
```

> PostgreSQL 有一个少为人知的系统变量叫作 user ， 它代表了当前登录用户的名称。 执行 SELECT user 就能看到其名称。
> 对于search_path 里的$user, 如果当前登录的角色是 `doggy`, 那么所有的查询都会优先去 `doggy` schema 中寻找目标表， 如果找不到才会去 public schema 下找

设置新的schema倒search path里

```sql
SET search_path TO myschema,public;
```
这样 默认 创建访问 table 都在 `myschema` schema里

