defmodule Webserver.Plugins do
  alias Webserver.Conv

  @doc """
  Logs 404 requests
  """
  def track(%Conv{status: 404, path: path} = conv) do
    IO.puts("#{path} is underdevelopment")
    conv
  end

  def track(%Conv{} = conv), do: conv

  def rewrite_path(%Conv{path: "/math"} = conv) do
    %{conv | path: "/templates"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv), do: IO.inspect(conv)
end
