defmodule CodomariBackend.MixProject do
  use Mix.Project

  def project do
    Code.require_file("lib/codomari/src/codomari.ex")
    manifest = Codomari.manifest()

    [
      apps_path: "apps",
      version: manifest[:version],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end


  defp deps do
    [
      # linter
      {:credo, "~> 1.7"},

      # database and pooling
      {:couchbeam, "~> 1.5.3"},
      {:poolboy, "~> 1.5.2"},

      # fixes issue in Couchbeam
      # https://github.com/benoitc/couchbeam/issues/200
      {:jsx, "2.8.3", override: true}
    ]
  end

  defp elixirc_paths(:test), do: ["lib/codomari/src", "lib/codomari/test/support"]
  defp elixirc_paths(_), do: ["lib/codomari/src"]

  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end
end
