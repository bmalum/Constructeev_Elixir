defmodule Constructeev.FeedbackController do
  use Constructeev.Web, :controller

  alias Constructeev.Feedback
  alias Constructeev.Channel

  plug :scrub_params, "feedback" when action in [:create, :update]

  def index(conn, _params) do
    feedbacks = Repo.all(Feedback)
    render(conn, "index.json", feedbacks: feedbacks)
  end

  def create(conn,  %{"channel_id" => channel_id, "feedback" => feedback_params}) do
    changeset = Channel |> Repo.get(channel_id) |> Ecto.Model.build(:feedbacks) |> Feedback.changeset(feedback_params)

    case Repo.insert(changeset) do
      {:ok, feedback} ->
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
