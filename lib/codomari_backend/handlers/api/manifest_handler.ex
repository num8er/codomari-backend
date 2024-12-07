defmodule CodomariBackend.Handlers.Api.ManifestHandler do
  @moduledoc """
  Handler serves information about the service.
  """

  use CodomariBackend, :controller

  @doc """
  Returns information about the service to connection as json.
  """
  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, _params) do
    CodomariBackend.manifest()
    |> Jason.OrderedObject.new()
    |> then(&json(conn, &1))
  end
end
