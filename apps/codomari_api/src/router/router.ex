defmodule CodomariApi.Router do
  use CodomariApi, :router

  alias Handlers.IndexPageHandler
  alias Handlers.ManifestHandler
  alias Handlers.V1.Db.InfoHandler, as: DbInfoHandler

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:put_root_layout, html: {CodomariApi.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  # /manifest
  get("/manifest", ManifestHandler, :handle)

  # /v1
  scope "/v1", CodomariApi do
    pipe_through(:api)

    # /v1/db/info
    get("/db/info", DbInfoHandler, :handle)
  end

  scope "/", CodomariApi do
    pipe_through(:browser)

    get("/", IndexPageHandler, :handle)
  end
end
