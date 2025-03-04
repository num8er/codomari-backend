defmodule CodomariApi.MixProject do
  use Mix.Project

  def project do
    Code.require_file("../../lib/codomari/lib/codomari.ex")
    Code.require_file("lib/codomari_api.ex")
    manifest = CodomariApi.manifest()

    [
      app: manifest[:name],
      version: manifest[:version],
      type: manifest[:type],
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
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
      mod: {CodomariApi.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  def releases do
    [
      codomari_api: [
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
      {:codomari, path: "../../lib/codomari"}
      # do not add deps here, add them to the (root) codomari mix project (which imported above)
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
