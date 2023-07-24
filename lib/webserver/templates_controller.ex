defmodule Webserver.TemplatesController do
  def index(conv) do
    %{conv | status: 200, resp_body: "Finance, Economics, Accounting"}
  end

  def show(conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Template: #{id}"}
  end
end
