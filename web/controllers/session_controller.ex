defmodule Constructeev.SessionController do
  use Constructeev.Web, :controller
  alias Constructeev.Channel

  def index(conn, _params) do
    channel = get_session(conn, :channel)
    if channel do 
      render(conn, "show.json", channel: channel)
    else
      render(conn, "error.json", error_msg: "Invalid Session")
    end

  end

  def create(conn, %{"sec_hash" => sec_hash}) do
    channel = Repo.get_by(Channel, sec_hash: sec_hash)
    if channel do
      conn = put_session(conn, :valid, true)     
      conn = put_session(conn, :channel, channel)     
      render(conn, "show.json", channel: channel)
    else
      render(conn, "error.json", error_msg: "Invalid Security Hash")
    end
  end

  def delete(conn, _params) do
    clear_session(conn)
    send_resp(conn, :no_content, "")
  end

end