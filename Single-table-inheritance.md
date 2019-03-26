# Single table inheritance
 
单表继承

[https://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html]

> Active Record allows inheritance by storing the name of the class in a column that by default is named “type” (can be changed by overwriting Base.inheritance_column). This means that an inheritance looking like this:

Active Record 允许column `type` 存储 class 名来表示继承

示例

```ruby
class Company < ActiveRecord::Base; end
class Firm < Company; end
class Client < Company; end
class PriorityClient < Client; end
```
