defmodule ContactUsWeb.Router do
  use ContactUsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ContactUsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ContactUsWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/contact", ContactController, :index
    post "/contact", ContactController, :create
  end
end