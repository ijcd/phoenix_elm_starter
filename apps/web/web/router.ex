defmodule Web.Router do
  use Web.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug Web.Context
  end

  scope "/", Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/graphql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: Web.Schema
  end

  scope "/graphiql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL, schema: Web.Schema
    post "/", Absinthe.Plug.GraphiQL, schema: Web.Schema
  end
end
