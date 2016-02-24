defmodule Constructeev.FeedbackPropertyControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.FeedbackProperty
  @valid_attrs %{favorite: true, unread: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feedback_property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    feedback_property = Repo.insert! %FeedbackProperty{}
    conn = get conn, feedback_property_path(conn, :show, feedback_property)
    assert json_response(conn, 200)["data"] == %{"id" => feedback_property.id,
      "feedback_id" => feedback_property.feedback_id,
      "unread" => feedback_property.unread,
      "favorite" => feedback_property.favorite}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, feedback_property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, feedback_property_path(conn, :create), feedback_property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(FeedbackProperty, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feedback_property_path(conn, :create), feedback_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    feedback_property = Repo.insert! %FeedbackProperty{}
    conn = put conn, feedback_property_path(conn, :update, feedback_property), feedback_property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(FeedbackProperty, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feedback_property = Repo.insert! %FeedbackProperty{}
    conn = put conn, feedback_property_path(conn, :update, feedback_property), feedback_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    feedback_property = Repo.insert! %FeedbackProperty{}
    conn = delete conn, feedback_property_path(conn, :delete, feedback_property)
    assert response(conn, 204)
    refute Repo.get(FeedbackProperty, feedback_property.id)
  end
end
