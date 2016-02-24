defmodule Constructeev.FeedbackController do
  use Constructeev.Web, :controller

  alias Constructeev.Feedback
  alias Constructeev.FeedbackProperty
  alias Constructeev.Channel

  plug :scrub_params, "feedback" when action in [:create, :update]

  def index(conn, %{"channel_id" => channel_id}) do
    feedbacks = Repo.all(from p in Feedback, where: is_nil(p.feedback_id), where: p.channel_id == ^channel_id, order_by: [desc: p.id],limit: 100)  
    render(conn, "index.json", feedbacks: feedbacks)
  end

  def create(conn,  %{"channel_id" => channel_id, "feedback" => feedback_params}) do
    changeset = Channel |> Repo.get(channel_id) |> Ecto.Model.build(:feedbacks) |> Feedback.changeset(feedback_params)
    IO.inspect Dict.get(feedback_params, "feedback_id")
    feedback_id = Dict.get(feedback_params, "feedback_id")
    case feedback_id do 
      nil ->  query = from f in Channel, where: f.id == ^channel_id
              Repo.update_all(query, inc: [feedback_counter: 1])
      _   ->  query = from f in Feedback, where: f.id == ^feedback_id
              Repo.update_all(query, inc: [feedback_childs: 1])
    end



    case Repo.insert(changeset) do
      {:ok, feedback} ->
        property = %{unread: false, favorite: false, feedback_id: feedback.id, channel_id: channel_id}
        changeset2 = FeedbackProperty.changeset(%FeedbackProperty{}, property)
        Repo.insert(changeset2)
        conn
        |> put_status(:created)
        |> render("show.json", feedback: feedback)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback = Repo.get!(Feedback, id)
    render(conn, "show.json", feedback: feedback)
  end

  def children(conn, %{"channel_id" => channel_id, "feedback_id" => feedback_id}) do
    feedbacks = Repo.all(from p in Feedback, where: p.feedback_id == ^feedback_id)
    if feedbacks do
      render(conn, "index.json", feedbacks: feedbacks)
    else
      render(conn, "error.json", error_msg: "No children found")
    end
  end

  def like(conn, %{"channel_id" => channel_id, "feedback_id" => feedback_id}) do
      query = from f in Feedback, where: f.id == ^feedback_id
      Repo.update_all(query, inc: [happiness: 1])
      render(conn, "success.json", error_msg: "true")
  end

  def dislike(conn, %{"channel_id" => channel_id, "feedback_id" => feedback_id}) do
      query = from f in Feedback, where: f.id == ^feedback_id
      Repo.update_all(query, inc: [happiness: -1])
      render(conn, "success.json", error_msg: "ture")
  end


  def update(conn, %{"id" => id, "feedback" => feedback_params}) do
    feedback = Repo.get!(Feedback, id)
    changeset = Feedback.changeset(feedback, feedback_params)

    case Repo.update(changeset) do
      {:ok, feedback} ->
        render(conn, "show.json", feedback: feedback)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Constructeev.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback = Repo.get!(Feedback, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feedback)

    send_resp(conn, :no_content, "")
  end
end
