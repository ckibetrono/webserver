defmodule Webserver.Consultancy do
  alias Webserver.Blueprint

  def list_blueprints do
    [
      %Blueprint{id: 1, name: "Budgeting", category: "personal_finance", display: true},
      %Blueprint{id: 2, name: "Valuation", category: "Corporate finance"},
      %Blueprint{
        id: 3,
        name: "Financial statements",
        category: "corporate finance",
        display: false
      },
      %Blueprint{
        id: 4,
        name: "Life cycle hypothesis",
        category: "personal_finance",
        display: true
      },
      %Blueprint{id: 5, name: "Taxes and expenditure", category: "Public finance"},
      %Blueprint{id: 6, name: "Cryptocurrency", category: "digital finance"},
      %Blueprint{id: 7, name: "Mpesa", category: "personal_finance", display: true},
      %Blueprint{id: 8, name: "Loans and savings", category: "banking", display: true},
      %Blueprint{id: 9, name: "Royalties", category: "passive income"},
      %Blueprint{id: 10, name: "Lottery", category: "gambling"}
    ]
  end

  def get_blueprint(id) when is_integer(id) do
    Enum.find(list_blueprints(), fn t -> t.id == id end)
  end

  def get_blueprint(id) when is_binary(id) do
    id |> String.to_integer() |> get_blueprint()
  end
end
