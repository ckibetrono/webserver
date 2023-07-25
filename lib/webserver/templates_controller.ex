defmodule Webserver.TemplatesController do
  alias Webserver.Consultancy
  alias Webserver.Template

  defp template_item(template) do
    "<li>#{template.name} - #{template.category}</li>"
  end

  def index(conv) do
    items =
      Consultancy.list_templates()
      |> Enum.filter(fn t -> Template.is_personal_finance(t) end)
      |> Enum.sort(&Template.order_asc_by_name/2)
      |> Enum.map(&template_item(&1))
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    template = Consultancy.get_template(id)
    %{conv | status: 200, resp_body: "<h1>Template #{template.id}: #{template.name}</h1>"}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{type} template named #{name}"
    }
  end
end
