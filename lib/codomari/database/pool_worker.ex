defmodule Codomari.Database.PoolWorker do
  @moduledoc """
  Worker process for managing a CouchDB connection.
  """

  use GenServer

  alias :couchbeam, as: Couchbeam

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    %{conn: conn, db: db} = connect()

    IO.puts("DB!!!")
    {:ok, %{conn: conn, db: db}}
  end

  def connect do
    config = Application.get_env(:databases, :couchdb)

    host = Keyword.fetch!(config, :host)
    port = Keyword.fetch!(config, :port)
    username = Keyword.get(config, :username, nil)
    password = Keyword.get(config, :password, nil)

    IO.puts(~s(#{host} #{port} #{username} #{password}))
    conn = open_connection(host, port, username, password)
    {:ok, db} = open_database(conn)

    %{conn: conn, db: db}
  end

  def open_connection(host, port, nil, nil) do
    Couchbeam.server_connection(
      ~s(http://#{host}:#{port}),
      []
    )
  end

  def open_connection(host, port, username, password) do
    Couchbeam.server_connection(
      ~s(http://#{host}:#{port}),
      basic_auth: {username, password}
    )
  end

  def open_database(conn) do
    config = Application.get_env(:databases, :couchdb)

    database = Keyword.fetch!(config, :database)

    Couchbeam.open_db(conn, database)
  end

  def handle_call(:get_connection, _from, state) do
    {:reply, state[:conn], state}
  end

  def handle_call(:get_db, _from, state) do
    {:reply, state[:db], state}
  end

  def handle_call(:server_info, _from, state) do
    {:ok, server_info} = Couchbeam.server_info(state[:conn])
    {:reply, server_info, state}
  end
end
