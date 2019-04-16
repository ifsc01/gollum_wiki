# rspec `raise_error`_ 
[https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/raise-error-matcher](https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/raise-error-matcher)

> Use the raise_error matcher to specify that a block of code raises an error. The most_

代码块 除法 错误

basic form passes if any error is thrown:

` expect { raise StandardError }.to raise_error`

也可以这样

`  expect { 3 / 0 }.to raise_exception` 

`raise_error` 和 `raise_exception ` 功能上是一样的

指定更多的细节

```ruby
  expect { raise "oops" }.to raise_error
  expect { raise "oops" }.to raise_error(RuntimeError)
  expect { raise "oops" }.to raise_error("oops")
  expect { raise "oops" }.to raise_error(/op/)
  expect { raise "oops" }.to raise_error(RuntimeError, "oops")
  expect { raise "oops" }.to raise_error(RuntimeError, /op/)
```
