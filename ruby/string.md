##  string formatting operator % 

```
>> template = "%{name} is the best %{occupation} in %{city}."
>> vals = {:name => "Joe Smith", :occupation => "birthday clown", :city => "Las Vegas"}
>> template % vals
=> "Joe Smith is the best birthday clown in Las Vegas."
```

https://stackoverflow.com/questions/6258516/how-to-match-and-replace-templating-tags-in-ruby-rails