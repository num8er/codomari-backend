defmodule CodomariBackend.Router do
  use CodomariBackend, :router

  alias Handlers.Api.ManifestHandler, as: ManifestHandler
  alias Handlers.Public.IndexPageHandler, as: IndexPageHandler

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_root_layout, html: {CodomariBackend.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api", CodomariBackend do
    pipe_through :api

    get "/", ManifestHandler, :handle
    get "/manifest", ManifestHandler, :handle
  end

  scope "/", CodomariBackend do
    pipe_through :browser

    get "/", IndexPageHandler, :handle
  end
end
