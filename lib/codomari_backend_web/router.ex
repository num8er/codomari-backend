defmodule CodomariBackendWeb.Router do
  use CodomariBackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CodomariBackendWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/public", CodomariBackendWeb do
    pipe_through :browser

    get "/", PageController, :manifest
  end
end
