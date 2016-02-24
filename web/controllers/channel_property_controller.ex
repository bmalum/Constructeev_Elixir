defmodule Constructeev.ChannelPropertyController do
  use Constructeev.Web, :controller

  alias Constructeev.ChannelProperty

  plug :scrub_params, "channel_property" when action in [:create, :update]

  def index(conn, _params) do
    channel_properties = Repo.all(ChannelProperty)
    render(conn, "index.json", channel_properties: channel_properties)
  end

  def create(conn, %{"channel_property" => channel_property_params}) do
    changeset = ChannelProperty.changeset(%ChannelProperty{}, channel_property_params)

    case Repo.insert(changeset) do
      {:ok, channel_property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", channel_property_path(conn, :show, channel_property))
        |> render("show.json", channel_property: channel_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    channel_property = Repo.get!(ChannelProperty, id)
    render(conn, "show.json", channel_property: channel_property)
  end

  def update(conn, %{"id" => id, "channel_property" => channel_property_params}) do
    channel_property = Repo.get!(ChannelProperty, id)
    changeset = ChannelProperty.changeset(channel_property, channel_property_params)

    case Repo.update(changeset) do
      {:ok, channel_property} ->
        render(conn, "show.json", channel_property: channel_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    channel_property = Repo.get!(ChannelProperty, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(channel_property)

    send_resp(conn, :no_content, "")
  end
end
