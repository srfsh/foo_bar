defmodule FooBarTest do
  use ExUnit.Case
  doctest FooBar

  test "greets the world" do
    assert FooBar.hello() == :world
  end
end
