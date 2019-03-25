# ActiveRecord’s queries tricks 小记

原文 https://medium.com/rubyinside/active-records-queries-tricks-2546181a98dd

## 关联表join时使用条件

```ruby
# User model
scope :activated, ->{
  joins(:profile).where(profiles: { activated: true })
}
```

更好的做法 

```
# Profile model
scope :activated, ->{ where(activated: true) }
# User model
scope :activated, ->{ joins(:profile).merge(Profile.activated) }
```

关于 merge
https://apidock.com/rails/ActiveRecord/SpawnMethods/merge
https://api.rubyonrails.org/classes/ActiveRecord/SpawnMethods.html

## 嵌套join的差异

* **User has_one Profile**
* **Profile has_many Skills**


```
User.joins(:profiles).merge(Profile.joins(:skills))
=> SELECT users.* FROM users 
   INNER JOIN profiles    ON profiles.user_id  = users.id
   LEFT OUTER JOIN skills ON skills.profile_id = profiles.id
# So you'd rather use:
User.joins(profiles: :skills)
=> SELECT users.* FROM users 
   INNER JOIN profiles ON profiles.user_id  = users.id
   INNER JOIN skills   ON skills.profile_id = profiles.id
   
```

内链接和外连接


## Exist query

存在和不存在

```
# Post
scope :famous, ->{ where("view_count > ?", 1_000) }
# User
scope :without_famous_post, ->{
  where(_not_exists(Post.where("posts.user_id = users.id").famous))
}
def self._not_exists(scope)
  "NOT #{_exists(scope)}"
end
def self._exists(scope)
  "EXISTS(#{scope.to_sql})"
end
```

## Subqueries 子查询

比如查询部分用户(user)的帖子(post)

不好的做法

```
Post.where(user_id: User.created_last_month.pluck(:id))
```

这里的缺陷是将运行两个SQL查询：一个用于获取用户的ID，另一个用于从这些user_id获取帖子

这样写一个查询就可以了
```
Post.where(user_id: User.created_last_month)
```


## 基础

.to_sql 生成 SQL 语句字符串
.explain 获取查询分析

## Booleans

对于`User.where.not(tall: true)`在pg下会生成
`SELECT users.* FROM users WHERE users.tall <> 't'` 
这返回 tall 是 false 的 记录，不包括是null 的

包括null应该这么写

```
User.where("users.tall IS NOT TRUE")
```
or 
```
User.where(tall: [false, nil])
```