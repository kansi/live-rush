defmodule RushHourWeb.Router do
  use RushHourWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RushHourWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", RushHourWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/export", ExportController, :index
  end
end
