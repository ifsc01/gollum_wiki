# Faraday Gem notes

[https://github.com/lostisland/faraday](https://github.com/lostisland/faraday)

 ![DraggedImage](media/15535221058226/DraggedImage.png)


[https://ruby-china.org/topics/26060](https://ruby-china.org/topics/26060)

支持开箱即用的adapter

 ![DraggedImage-1](media/15535221058226/DraggedImage-1.png)


第三方的adapter `Typhoeus`

## 基本使用

```ruby
response = Faraday.get 'http://sushi.com/nigiri/sake.json'
```

你可以只使用默认的中间件堆栈和默认适配器
[https://github.com/lostisland/faraday/blob/master/lib/faraday/rack\_builder.rb](https://github.com/lostisland/faraday/blob/master/lib/faraday/rack_builder.rb)

更复杂的用法是 new 一个 Connection 对象

```ruby
conn = Faraday.new(:url => 'http://www.example.com')
response = conn.get '/users'                 # GET http://www.example.com/users'
```


`Connections` 可以使用`options hash` 作为参数或使用`block`进行配置

```ruby
conn = Faraday.new(:url => 'http://sushi.com') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests and responses to $stdout
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

# Filter sensitive information from logs with a regex matcher

conn = Faraday.new(:url => 'http://sushi.com/api_key=s3cr3t') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger do | logger |
    logger.filter(/(api_key=)(\w+)/,'\1[REMOVED]')
  end
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

# Override the log formatting on demand
 
class MyFormatter < Faraday::Response::Logger::Formatter
  def request(env)
    info('Request', env)  
  end
  
  def request(env)
    info('Response', env)
  end
end

conn = Faraday.new(:url => 'http://sushi.com/api_key=s3cr3t') do |faraday|
  faraday.response :logger, StructLogger.new(STDOUT), formatter: MyFormatter
end

```

拿到conn后就可以发请求了

```ruby
## GET ##

response = conn.get '/nigiri/sake.json'     # GET http://sushi.com/nigiri/sake.json
response.body

conn.get '/nigiri', { :name => 'Maguro' }   # GET http://sushi.com/nigiri?name=Maguro

conn.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
  req.url '/search', :page => 2
  req.params['limit'] = 100
end

## POST ##

conn.post '/nigiri', { :name => 'Maguro' }  # POST "name=maguro" to http://sushi.com/nigiri
```

每个request都可以单独配置

```ruby
# post payload as JSON instead of "www-form-urlencoded" encoding:
conn.post do |req|
  req.url '/nigiri'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "name": "Unagi" }'
end

## Per-request options ##

conn.get do |req|
  req.url '/search'
  req.options.timeout = 5           # open/read timeout in seconds
  req.options.open_timeout = 2      # connection open timeout in seconds
end

## Streaming responses ##

streamed = []                       # A buffer to store the streamed data
conn.get('/nigiri/sake.json') do |req|
  # Set a callback which will receive tuples of chunk Strings
  # and the sum of characters received so far
  req.options.on_data = Proc.new do |chunk, overall_received_bytes|
    puts "Received #{overall_received_bytes} characters"
    streamed << chunk
  end
end
streamed.join
```


也可以注入一些随意的数据到`context` 这样所有middleware都可以访问了

```ruby
# Anything you inject using context option will be available in the env on all middlewares

conn.get do |req|
  req.url '/search'
  req.options.context = {
      foo: 'foo',
      bar: 'bar'
  }
end
```



## Advanced middleware usage

The order in which middleware is stacked is important. Like with Rack, the first middleware on the list wraps all others, while the last middleware is the innermost one, so that must be the adapter.

中间件堆叠的顺序很重要。与Rack一样，列表中的第一个中间件包装了所有其他中间件，而最后一个中间件是最里面的中间件，因此必须是适配器。

```ruby
Faraday.new(...) do |conn|
  # POST/PUT params encoders:
  conn.request :multipart
  conn.request :url_encoded

  # Last middleware must be the adapter:
  conn.adapter :net_http
end
```

两个middleware

- `Request::Multipart`   检查payload 是否有文件, 否则一切都不会受到影响;
- `Request::UrlEncoded` `application/x-www-form-urlencoded` 编码类型  


示例 payload 有文件, `Content-Type` 为 `multipart/form-data`     

```ruby
# uploading a file:
payload[:profile_pic] = Faraday::UploadIO.new('/path/to/avatar.jpg', 'image/jpeg')

# "Multipart" middleware detects files and encodes with "multipart/form-data":
conn.put '/profile', payload
```


## Writing middleware

实现 `call` 实例方法的class

```ruby
def call(request_env)
  # do something with the request
  # request_env[:request_headers].merge!(...)

  @app.call(request_env).on_complete do |response_env|
    # do something with the response
    # response_env[:response_headers].merge!(...)
  end
end
```

只在 `on_complete`  block 处理 response 是很重要的, 请求是异步的

`env` 包含request和response的信息

```ruby
# request phase
:method - :get, :post, ...
:url    - URI for the current request; also contains GET parameters
:body   - POST parameters for :post/:put requests
:request_headers

# response phase
:status - HTTP response status code, such as 200
:body   - the response body
:response_headers
```

## links

- GETTING STARTED WITH FARADAY GEM [https://redpanthers.co/getting-started-faraday-gem/](https://redpanthers.co/getting-started-faraday-gem/)
