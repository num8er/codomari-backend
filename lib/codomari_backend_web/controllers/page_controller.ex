defmodule CodomariBackendWeb.PageController do
  use CodomariBackendWeb, :controller

  def manifest(conn, _params) do
    manifest_path = Path.join(:code.priv_dir(:codomari_backend), "../codomari_backend.manifest")

    case File.read(manifest_path) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, data} -> json(conn, data)
          {:error, _} -> send_resp(conn, 500, "Invalid manifest JSON format")
        end

      {:error, _reason} ->
        send_resp(conn, 500, "Manifest file not found")
    end
  end
end

