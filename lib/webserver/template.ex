defmodule Webserver.Template do
  defstruct id: nil, name: "", category: "", display: false

  def is_personal_finance(template) do
    template.category == "personal_finance"
  end

  def order_asc_by_name(t1, t2) do
    t1.name <= t2.name
  end
end
