defmodule Webserver.BlueprintsController do
  alias Webserver.Consultancy
  alias Webserver.Blueprint

  @blueprints_path Path.expand("../webserver/blueprints", __DIR__)

  defp render(conv, blueprint, bindings \\ []) do
    content =
      @blueprints_path
      |> Path.join(blueprint)
      |> EEx.eval_file(bindings)

    %{conv | status: 200, resp_body: content}
  end

  def index(conv) do
    blueprints =
      Consultancy.list_blueprints()
      |> Enum.sort(&Blueprint.order_asc_by_name/2)

    render(conv, "index.eex", blueprints: blueprints)
  end

  def show(conv, %{"id" => id}) do
    blueprint = Consultancy.get_blueprint(id)

    render(conv, "show.eex", blueprint: blueprint)
  end

  def create(conv, %{"name" => name, "category" => category}) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{category} template named #{name}"
    }
  end
end
