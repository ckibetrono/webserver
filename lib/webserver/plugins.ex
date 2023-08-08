defmodule Webserver.Plugins do
  alias Webserver.Conv

  @doc """
  Logs 404 requests
  """
  # track 404s in development and production but not in test
  def track(%Conv{status: 404, path: path} = conv) do
    if Mix.env() != :test do
      IO.puts("#{path} is underdevelopment")
    end

    conv
  end

  def track(%Conv{} = conv), do: conv

  def rewrite_path(%Conv{path: "/math"} = conv) do
    %{conv | path: "/finance"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv) do
    if Mix.env() == :dev do
      IO.inspect(conv)
    end

    conv
  end
end
