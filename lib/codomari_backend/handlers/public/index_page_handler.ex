defmodule CodomariBackend.Handlers.Public.IndexPageHandler do
  use CodomariBackend, :controller

  def handle(conn, _params) do
    index_file = Path.join(:code.priv_dir(:codomari_backend), "../public/index.html")

    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, index_file)
  end
end
