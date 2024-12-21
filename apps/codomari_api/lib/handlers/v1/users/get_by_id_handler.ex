defmodule CodomariApi.Handlers.V1.Users.GetByIdHandler do
  @moduledoc """
  Responds with user object
  """

  use CodomariApi, :controller
  alias Codomari.Database.Methods, as: DB

  @doc """
  Returns information about the database
  """
  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, params) do
    params
    |> then(&json(conn, &1))
  end
end
