# authlogic 

## `crypto_provider` 

实现encrypt和matches? 类方法
[https://github.com/binarylogic/authlogic/blob/master/lib/authlogic/crypto\_providers/sha256.rb](https://github.com/binarylogic/authlogic/blob/master/lib/authlogic/crypto_providers/sha256.rb)
```ruby
     class MyAwesomeEncryptionMethod
      def self.encrypt(*tokens)
        # the tokens passed will be an array of objects, what type of object
        # is irrelevant, just do what you need to do with them and return a
        # single encrypted string. for example, you will most likely join all
        # of the objects into a single string and then encrypt that string
      end
  
      def self.matches?(crypted, *tokens)
        # return true if the crypted string matches the tokens. Depending on
        # your algorithm you might decrypt the string then compare it to the
        # token, or you might encrypt the tokens and make sure it matches the
        # crypted string, its up to you.
      end
    end
```
设置加密方式

## `transition_from_crypto_providers`

> Let's say you originally encrypted your passwords with Sha1. Sha1 is starting to join the party with MD5 and you want to switch to something stronger. No problem, just specify your new and improved algorithm with the crypt_provider option and then let Authlogic know you are transitioning from Sha1 using this option. Authlogic will take care of everything, including transitioning your users to the new algorithm. The next time a user logs in, they will be granted access using the old algorithm and their password will be resaved with the new algorithm. All new users will obviously use the new algorithm as well._

动态更新新的加密方式


