defmodule WebserverTest do
  use ExUnit.Case
  doctest Webserver

  test "greets the world" do
    assert Webserver.hello() == :world
  end

  test "the truth" do
    assert 1 + 1 == 2
  end
end
