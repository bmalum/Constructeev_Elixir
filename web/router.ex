defmodule Constructeev.Router do
  use Constructeev.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", Constructeev do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Constructeev do
     pipe_through :api

     resources "channels", ChannelController do
      resources "feedbacks", FeedbackController do 
        resources "messages", MessageController
      end
    end
     get "/sessions", SessionController, :index 
     post "/sessions", SessionController, :create
     delete "/sessions", SessionController, :delete 
  end

end
