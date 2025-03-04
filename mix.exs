defmodule CodomariBackend.MixProject do
  @moduledoc false

  use Mix.Project

  @spec project :: keyword()
  def project do
    [
      apps_path: "apps",
      version: "0.0.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: dialyzer()
    ]
  end

  @spec deps :: [{atom(), String.t()}]
  defp deps do
    [
      # linter
      {:credo, "~> 1.7"},

      # dialyzer
      {:dialyxir, "~> 1.4.5", only: [:dev], runtime: false}
    ]
  end

  @spec elixirc_paths(atom()) :: [String.t()]
  defp elixirc_paths(:test), do: []
  defp elixirc_paths(_), do: []

  @spec aliases :: keyword()
  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end

  @spec dialyzer :: keyword()
  defp dialyzer do
    [
      format: :dialyzer,
      paths: ["lib/*/lib", "apps/*/lib"],
      list_unused_filters: true,
      warnings: [
        :unmatched_returns,
        :error_handling,
        :race_conditions,
        :underspecs,
        :unknown
      ],
      ignore_warnings: ".dialyzer_ignore.exs"
    ]
  end
end
