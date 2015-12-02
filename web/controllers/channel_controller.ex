defmodule Constructeev.ChannelController do
  use Constructeev.Web, :controller

  alias Constructeev.Channel

  plug :scrub_params, "channel" when action in [:create, :update]

  def index(conn, _params) do
    channels =  Channel |> Repo.all |> Repo.preload [:feedbacks]
    render(conn, "index.json", channels: channels)
  end

  def create(conn, %{"channel" => channel_params}) do
    changeset = Channel.changeset(%Channel{}, channel_params)

    case Repo.insert(changeset) do
      {:ok, channel} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", channel_path(conn, :show, channel))
        |> render("show.json", channel: channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)
    render(conn, "show.json", channel: channel)
  end

  def search(conn, %{"name" => name}) do
    channel = Repo.get_by(Channel, name: name)
    if channel do
      render(conn, "show.json", channel: channel)
    else
      render(conn, "error.json", error_msg: "Channel not found")
    end
  end
  
  def update(conn, %{"id" => id, "channel" => channel_params}) do
    channel = Repo.get!(Channel, id)
    changeset = Channel.changeset(channel, channel_params)

    case Repo.update(changeset) do
      {:ok, channel} ->
        render(conn, "show.json", channel: channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(channel)

    send_resp(conn, :no_content, "")
  end
end
