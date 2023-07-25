defmodule Webserver.Consultancy do
  alias Webserver.Template

  def list_templates do
    [
      %Template{id: 1, name: "Budgeting", category: "personal_finance", display: true},
      %Template{id: 2, name: "Valuation", category: "Corporate finance"},
      %Template{
        id: 3,
        name: "Financial statements",
        category: "corporate finance",
        display: false
      },
      %Template{
        id: 4,
        name: "Life cycle hypothesis",
        category: "personal_finance",
        display: true
      },
      %Template{id: 5, name: "Taxes and expenditure", category: "Public finance"},
      %Template{id: 6, name: "Cryptocurrency", category: "digital finance"},
      %Template{id: 7, name: "Mpesa", category: "personal_finance", display: true},
      %Template{id: 8, name: "Loans and savings", category: "banking", display: true},
      %Template{id: 9, name: "Royalties", category: "passive income"},
      %Template{id: 10, name: "Lottery", category: "gambling"}
    ]
  end

  def get_template(id) when is_integer(id) do
    Enum.find(list_templates(), fn t -> t.id == id end)
  end

  def get_template(id) when is_binary(id) do
    id |> String.to_integer() |> get_template()
  end
end
