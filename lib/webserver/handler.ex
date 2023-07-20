defmodule Webserver.Handler do
  @moduledoc """
  Handles HTTP requests.
  """
  @pages_path Path.expand("../pages", __DIR__)

  import Webserver.Plugins, only: [rewrite_path: 1, log: 1, track: 1]

  import Webserver.Parser, only: [parse: 1]

  @doc """
  Transforms the request into a response
  """

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%{method: "GET", path: "/templates"} = conv) do
    %{conv | status: 200, resp_body: "Finance, Economics, Accounting"}
  end

  def route(%{method: "GET", path: "/finance"} = conv) do
    %{conv | status: 200, resp_body: "Personal finance, Public finance, Corporate finance"}
  end

  def route(%{method: "GET", path: "/finance" <> id} = conv) do
    %{conv | status: 200, resp_body: "Finance #{id}"}
  end

  def route(%{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%{path: path} = conv) do
    %{conv | status: 404, resp_body: "No #{path} here for #{conv.method} request!"}
  end

  def handle_file({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content}
  end

  def handle_file({:error, :enoent}, conv) do
    %{conv | status: 404, resp_body: "File not found!"}
  end

  def handle_file({:error, reason}, conv) do
    %{conv | status: 500, resp_body: "File error: #{reason}"}
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}
    
    #{conv.resp_body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end

request = """
GET /templates HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /finance/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /economics HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /math HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /mathformulas HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)