defmodule Codomari.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    Code.require_file("lib/codomari.ex")
    manifest = Codomari.manifest()

    [
      name: manifest[:name],
      version: manifest[:version],
      type: :library,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  defp deps do
    [
      # database and pooling
      {:couchbeam, "~> 1.5.3"},
      {:poolboy, "~> 1.5.2"},

      # fixes issue in Couchbeam
      # https://github.com/benoitc/couchbeam/issues/200
      {:jsx, "2.8.3", override: true},

      # Moving modules to core mix project to have 1 place defining

      # web framework and related deps
      {:plug_cowboy, "~> 2.5"},
      {:phoenix, "~> 1.7.9"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.1"},
      {:phoenix_live_dashboard, "~> 0.8.2"},

      # other necessary deps
      {:floki, ">= 0.30.0", only: :test},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"}

    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end
end
