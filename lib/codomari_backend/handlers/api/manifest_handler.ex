defmodule CodomariBackend.Handlers.Api.ManifestHandler do
  use CodomariBackend, :controller

  def handle(conn, _params) do
    project_data = project_from_mix()

    response_data =
      [
        project: "codomari",
        type: "service"
      ] ++
        project_data

    json(conn, Jason.OrderedObject.new(response_data))
  end

  defp project_from_mix do
    app = CodomariBackend.MixProject.project()[:app]
    version = CodomariBackend.MixProject.project()[:version]

    [
      name: Atom.to_string(app),
      version: version
    ]
  end
end
