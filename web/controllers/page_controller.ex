defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
