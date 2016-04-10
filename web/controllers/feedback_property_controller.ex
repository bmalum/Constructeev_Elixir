defmodule Constructeev.FeedbackPropertyController do
  use Constructeev.Web, :controller

  alias Constructeev.FeedbackProperty
  alias Constructeev.Feedback
  alias Constructeev.Channel

  plug :auth, "" when action in [:index, :show]
  plug :auth_write, "" when action in [:create, :update]
  plug :scrub_params, "feedback_property" when action in [:create, :update]

  def index(conn, _params) do
    id = Dict.get(_params, "channel_id")
   # feedback_properties = Repo.all(from(p in FeedbackProperty, where: p.channel_id == ^id)) |> Repo.preload [:feedback]
  #  feedback_properties = Repo.all(from(p in Feedback, where: p.id == ^id, where: is_nil(p.feedback_id))) |> Repo.preload [:feedback_properties]
   # IO.inspect feedback_properties
    query = from f in FeedbackProperty,
          left_join: p in Feedback, on: f.feedback_id == p.id, where: is_nil(p.feedback_id), where: p.channel_id == ^id
          feedback_properties = Repo.all(query) |> Repo.preload [:feedback]
          IO.inspect  feedback_properties

    render(conn, "index.json", feedback_properties: feedback_properties)
  end

  def create(conn, %{"feedback_property" => feedback_property_params}) do
    changeset = FeedbackProperty.changeset(%FeedbackProperty{}, feedback_property_params)

    case Repo.insert(changeset) do
      {:ok, feedback_property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", feedback_property_path(conn, :show, feedback_property))
        |> render("show.json", feedback_property: feedback_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback_property = Repo.get!(FeedbackProperty, id)
    render(conn, "show.json", feedback_property: feedback_property)
  end

  def update(conn, %{"id" => id, "feedback_property" => feedback_property_params}) do
    feedback_property = Repo.get!(FeedbackProperty, id)
    changeset = FeedbackProperty.changeset(feedback_property, feedback_property_params)

    case Repo.update(changeset) do
      {:ok, feedback_property} ->
        render(conn, "show_property.json", feedback_property: feedback_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback_property = Repo.get!(FeedbackProperty, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feedback_property)
    send_resp(conn, :no_content, "")
  end

  defp auth(conn, _) do
   channel_id = get_session(conn, :channel_id)
   {id, _}  = Integer.parse(conn.params["channel_id"])
    if channel_id == id do
      conn 
    else
      send_resp(conn, 401, "NOT AUTHORIZED") |> halt()
    end
  end

  defp auth_write(conn, _) do
   channel_id = get_session(conn, :channel_id)
   id =  conn.body_params["feedback_property"]["channel_id"]
   #{id, _}  = Integer.parse(conn.params["channel_id"])
    if channel_id == id do
      conn 
    else
      send_resp(conn, 401, "NOT AUTHORIZED") |> halt()
    end
  end

end
