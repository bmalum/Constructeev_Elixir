defmodule Constructeev.ChannelPropertyControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.ChannelProperty
  @valid_attrs %{hidden_feedback: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, channel_property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    channel_property = Repo.insert! %ChannelProperty{}
    conn = get conn, channel_property_path(conn, :show, channel_property)
    assert json_response(conn, 200)["data"] == %{"id" => channel_property.id,
      "channel_id" => channel_property.channel_id,
      "hidden_feedback" => channel_property.hidden_feedback}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, channel_property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, channel_property_path(conn, :create), channel_property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ChannelProperty, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, channel_property_path(conn, :create), channel_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    channel_property = Repo.insert! %ChannelProperty{}
    conn = put conn, channel_property_path(conn, :update, channel_property), channel_property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ChannelProperty, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    channel_property = Repo.insert! %ChannelProperty{}
    conn = put conn, channel_property_path(conn, :update, channel_property), channel_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    channel_property = Repo.insert! %ChannelProperty{}
    conn = delete conn, channel_property_path(conn, :delete, channel_property)
    assert response(conn, 204)
    refute Repo.get(ChannelProperty, channel_property.id)
  end
end
