defmodule CodomariApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias :poolboy, as: Poolboy

  @impl true
  def start(_type, _args) do
    database_pool_config = get_pool_config(:couchdb_pool)

    children = [
      CodomariApi.Telemetry,
      {DNSCluster, query: Application.get_env(:codomari_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CodomariApi.PubSub},

      # Start the Finch HTTP client for sending emails
      {Finch, name: CodomariApi.Finch},

      # Start a worker by calling: CodomariApi.Worker.start_link(arg)
      # {CodomariApi.Worker, arg},
      # Start to serve requests, typically the last entry
      CodomariApi.Endpoint,

      # DB Pool
      Poolboy.child_spec(database_pool_config[:name], database_pool_config)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodomariApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_pool_config(pool_name) do
    Application.get_env(:codomari, pool_name)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodomariApi.Endpoint.config_change(changed, removed)
    :ok
  end
end
