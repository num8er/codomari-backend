defmodule CodomariBackendWeb.PageController do
  use CodomariBackendWeb, :controller

  def manifest(conn, _params) do
    manifest_path = Path.join(:code.priv_dir(:codomari_backend), "../codomari_backend.manifest")

    case parse_manifest_file(manifest_path) do
      {:ok, data} ->
        json(conn, Jason.OrderedObject.new(data))

      {:error, reason} ->
        send_resp(conn, 500, reason)
    end
  end

  defp parse_manifest_file(path) do
    with {:ok, content} <- File.read(path),
         {:ok, parsed_data} <- parse_key_value_pairs(content) do
      {:ok, parsed_data}
    else
      {:error, _} -> {:error, "Error reading or parsing manifest file"}
    end
  end

  defp parse_key_value_pairs(content) do
    lines = String.split(content, "\n", trim: true)

    key_value_pairs =
      Enum.reduce_while(lines, [], fn line, acc ->
        case String.split(line, "=", parts: 2) do
          [key, value] -> {:cont, acc ++ [{String.downcase(key), value}]}
          _ -> {:halt, {:error, "Invalid format in manifest file"}}
        end
      end)

    case key_value_pairs do
      {:error, _} = error -> error
      _ -> {:ok, key_value_pairs}
    end
  end
end

