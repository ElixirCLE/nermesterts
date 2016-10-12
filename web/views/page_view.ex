defmodule Nermesterts.PageView do
  use Nermesterts.Web, :view

  def name_of_the(game) do
    case game do
      %{name: name} -> "<h3>" <> name <> "</h3>"
      _ -> ""
    end
  end
end
