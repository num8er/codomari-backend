defmodule CodomariApi.Handlers.ManifestHandler do
  @moduledoc """
  Handler serves information about the service.
  """

  use CodomariApi, :controller

  @doc """
  Returns information about the service to connection as json.
  """
  def handle(conn, _params) do
    CodomariApi.manifest()
    |> Jason.OrderedObject.new()
    |> then(&json(conn, &1))
  end
end
