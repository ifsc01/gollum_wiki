# Elixir in Action 笔记 模块属性

2.3.6  Module attributes

模块属性的目的有两个：它们可以用作编译时常量，您可以注册任何属性，然后可以在运行时查询。

示例一

```elixir
iex(1)> defmodule Circle do
          @pi 3.14159

          def area(r), do: r*r*@pi
          def circumference(r), do: 2*r*@pi
        end

iex(2)> Circle.area(1)
3.14159

iex(3)> Circle.circumference(1)
6.28318
```

`@pi` 存在于编译时

Elixir默认注册一些模块属性。例如，`@moduledoc`和`@doc`属性 可用于提供模块和函数的文档

示例

```elixir
defmodule Circle do
  @moduledoc "Implements basic circle functions"
  @pi 3.14159

  @doc "Computes the area of a circle"
  def area(r), do: r*r*@pi

  @doc "Computes the circumference of a circle"
  def circumference(r), do: 2*r*@pi
end
```

可以在运行时检索`moduledoc`属性 (使用  elixirc circle.ex 编译, 生成 Elixir.Circle.beam) 

```
iex(1)> Code.get_docs(Circle, :moduledoc)
{1, "Implements basic circle functions"}
```

iex中使用h函数查看模块文档

```
iex(2)> h Circle
                                     Circle
Implements basic circle functions

iex(3)> h Circle.area
                                  def area(r)
Computes the area of a circle
```

## Type specifications

为函数提供类型信息
使用 dialyzer(http://erlang.org/doc/man/dialyzer.html) 会根据类型注解做静态分析检查

示例 

```elixir
defmodule Circle do
  @pi 3.14159

  @spec area(number) :: number
  def area(r), do: r*r*@pi

  @spec circumference(number) :: number
  def circumference(r), do: 2*r*@pi
end
```

`@spec` 提供类型信息，表示函数接受number 返回 number



