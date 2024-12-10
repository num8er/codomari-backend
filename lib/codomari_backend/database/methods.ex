defmodule CodomariBackend.Database.Methods do
  @moduledoc """
  Module to provide CouchDB methods.
  """

  alias :poolboy, as: Poolboy

  def get_server_info() do
    Poolboy.transaction(:couchdb_pool, fn worker_pid ->
      server_info = GenServer.call(worker_pid, :server_info)

      IO.inspect(server_info)
      server_info
    end)
  end
end
