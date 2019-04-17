##  string formatting operator % 

```
>> template = "%{name} is the best %{occupation} in %{city}."
>> vals = {:name => "Joe Smith", :occupation => "birthday clown", :city => "Las Vegas"}
>> template % vals
=> "Joe Smith is the best birthday clown in Las Vegas."
```


![doc](https://ifsc010101.blob.core.windows.net/abcdefg/1555507321.png)

http://ruby-doc.org/core-2.6.2/String.html#method-M001127

https://stackoverflow.com/questions/6258516/how-to-match-and-replace-templating-tags-in-ruby-rails