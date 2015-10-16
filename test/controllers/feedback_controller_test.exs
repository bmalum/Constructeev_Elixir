defmodule Constructeev.FeedbackControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.Feedback
  @valid_attrs %{author: "some content", content: "some content", happiness: 42, title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feedback_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = get conn, feedback_path(conn, :show, feedback)
    assert json_response(conn, 200)["data"] == %{"id" => feedback.id,
      "title" => feedback.title,
      "author" => feedback.author,
      "content" => feedback.content,
      "happiness" => feedback.happiness,
      "channel_id" => feedback.channel_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, feedback_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, feedback_path(conn, :create), feedback: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Feedback, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feedback_path(conn, :create), feedback: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = put conn, feedback_path(conn, :update, feedback), feedback: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Feedback, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = put conn, feedback_path(conn, :update, feedback), feedback: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = delete conn, feedback_path(conn, :delete, feedback)
    assert response(conn, 204)
    refute Repo.get(Feedback, feedback.id)
  end
end
