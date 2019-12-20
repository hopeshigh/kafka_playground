defmodule KafkaPlaygroundWeb.PageController do
  use KafkaPlaygroundWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
