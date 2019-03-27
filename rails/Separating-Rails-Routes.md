## code example from buledoc

https://github.com/thebluedoc/bluedoc/blob/master/lib/bluedoc/action_dispatch/draw_route.rb

```ruby

# frozen_string_literal: true

module BlueDoc
  module ActionDispatch
    module DrawRoute
      def draw(routes_name)
        route = draw_route(Rails.root.join("config/routes/#{routes_name}.rb"))

        route || raise("Cannot find #{routes_name}")
      end

      private

        def draw_route(path)
          return false unless File.exist?(path)

          instance_eval(File.read(path))
          true
        end
    end
  end
end

```


https://github.com/thebluedoc/bluedoc/blob/master/config/initializers/action_dispatch_routing.rb

```ruby
# frozen_string_literal: true

# Adds draw method into Rails routing
# It allows us to keep routing split into files
ActionDispatch::Routing::Mapper.prepend BlueDoc::ActionDispatch::DrawRoute

```

## links

- [Separating Rails Routes](http://wiki.dsh.li/edit/rails/Separating-Rails-Routes)
- [bluedoc/draw_route.rb at master · thebluedoc/bluedoc](https://github.com/thebluedoc/bluedoc/blob/master/lib/bluedoc/action_dispatch/draw_route.rb)
- [bluedoc/action_dispatch_routing.rb at master · thebluedoc/bluedoc](https://github.com/thebluedoc/bluedoc/blob/master/config/initializers/action_dispatch_routing.rb)
- [ActionDispatch::Routing::Mapper](https://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper.html)
- [ActionDispatch::Routing::Mapper::Base](https://api.rubyonrails.org/v5.1.4/classes/ActionDispatch/Routing/Mapper/Base.html)
