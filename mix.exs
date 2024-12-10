defmodule CodomariBackend.MixProject do
  use Mix.Project

  def project do
    Code.require_file("lib/codomari_backend.ex")

    manifest = CodomariBackend.manifest()

    [
      app: manifest[:app],
      version: manifest[:version],
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CodomariBackend.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  def releases do
    [
      codomari_backend: [
        include_executables_for: [:unix],
        applications: [
          runtime_tools: :permanent,
          telemetry_metrics: :permanent,
          telemetry_poller: :permanent
        ],
        steps: [
          :assemble,
          :tar
        ]
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # linter
      {:credo, "~> 1.7"},

      # database and pooling
      {:couchbeam, "~> 1.5.3"},
      {:poolboy, "~> 1.5.2"},

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

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
