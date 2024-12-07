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
    manifest = CodomariBackend.manifest()

    response_data =
      [
        project: Atom.to_string(manifest[:project]),
        type: Atom.to_string(manifest[:type]),
        name: Atom.to_string(manifest[:app]),
        version: manifest[:version]
      ]

    response_data
    |> Jason.OrderedObject.new()
    |> then(&json(conn, &1))
  end
end
