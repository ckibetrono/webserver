defmodule Webserver.Plugins do
  @doc """
  Logs 404 requests
  """
  def track(%{status: 404, path: path} = conv) do
    IO.puts("#{path} is underdevelopment")
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%{path: "/math"} = conv) do
    %{conv | path: "/finance"}
  end

  def rewrite_path(conv), do: conv

  def log(conv), do: IO.inspect(conv)
end
