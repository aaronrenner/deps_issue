defmodule TestOnlyDepTest do
  use ExUnit.Case
  doctest TestOnlyDep

  test "greets the world" do
    assert TestOnlyDep.hello() == :world
  end
end
