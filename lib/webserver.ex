defmodule Webserver do
  @moduledoc """
  Documentation for `Webserver`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Webserver.hello()
      :world

  """
  def hello do
    :world
  end

  def hello(name) do
    "Hello, #{name}!"
  end

  IO.puts(Webserver.hello())
  IO.puts(Webserver.hello("Chris"))
end
