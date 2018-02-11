defmodule ExconsulTest do
  use ExUnit.Case
  doctest Exconsul

  test "greets the world" do
    assert Exconsul.hello() == :world
  end
end
