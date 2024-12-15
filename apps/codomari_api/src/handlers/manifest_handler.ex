defmodule CodomariApi.Handlers.V1.ManifestHandler do
  @moduledoc """
  Handler serves information about the service.
  """

  use CodomariApi, :controller

  @doc """
  Returns information about the service to connection as json.
  """
  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, _params) do
    CodomariApi.manifest()
    |> Jason.OrderedObject.new()
    |> then(&json(conn, &1))
  end
end
