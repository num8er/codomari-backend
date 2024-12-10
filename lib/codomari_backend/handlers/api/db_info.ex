defmodule CodomariBackend.Handlers.Api.DbInfo do
  @moduledoc """
  Handler serves information about database.
  """

  use CodomariBackend, :controller
  alias CodomariBackend.Database.Methods, as: DB

  @doc """
  Returns information about the database
  """
  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, _params) do
    DB.get_server_info()
    |> tuple_to_map()
    |> then(&json(conn, &1))
  end

  defp tuple_to_map({list}) when is_list(list) do
    list
    |> Enum.into(%{}, fn
      {key, value} when is_tuple(value) -> {key, tuple_to_map(value)}
      {key, value} -> {key, value}
    end)
  end

  defp tuple_to_map(other), do: other
end
