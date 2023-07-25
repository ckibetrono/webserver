defmodule Webserver.Handler do
  alias Webserver.Conv
  alias Webserver.TemplatesController

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

  def route(%Conv{method: "GET", path: "/templates"} = conv) do
    TemplatesController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/finance"} = conv) do
    %{conv | status: 200, resp_body: "Personal finance, Public finance, Corporate finance"}
  end

  def route(%Conv{method: "GET", path: "/templates/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    TemplatesController.show(conv, params)
  end

  # name=Risk&type=Return
  def route(%Conv{method: "POST", path: "/templates"} = conv) do
    TemplatesController.create(conv, conv.params)
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{path: path} = conv) do
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

  def format_response(%Conv{} = conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
POST /templates HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Risk&type=Return
"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /templates/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)

request = """
GET /templates HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Webserver.Handler.handle(request)

IO.puts(response)
