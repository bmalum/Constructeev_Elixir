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
    resources "/feedback_properties", FeedbackPropertyController, except: [:new, :edit]
    resources "/channel_properties", ChannelPropertyController, except: [:new, :edit]
    get "/", PageController, :index
  end

  scope "/api", Constructeev do
     pipe_through :api

     scope "/admin/" do
      resources "/feedback_properties", FeedbackPropertyController
      get "_debug", FeedbackPropertyController, :index
      get "_read", AdminController, :read
      get "_fav", AdminController, :fav
      get "_display", AdminController, :display
      get "_setstart", AdminController, :starttime
      get "_setstop", AdminController, :stoptime
     end

     resources "channels", ChannelController do
      get "_like", ChannelController, :like
      resources "feedbacks", FeedbackController do
        get "_like", FeedbackController, :like
        get "_dislike", FeedbackController, :dislike
        get "_children", FeedbackController, :children 
      end
    end
     get "/sessions", SessionController, :index 
     post "/sessions", SessionController, :create
     delete "/sessions", SessionController, :delete 
     get "/channel/_search", ChannelController, :search
  end

end
