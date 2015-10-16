defmodule Constructeev.ChannelControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.Channel
  @valid_attrs %{email: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, channel_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    channel = Repo.insert! %Channel{}
    conn = get conn, channel_path(conn, :show, channel)
    assert json_response(conn, 200)["data"] == %{"id" => channel.id,
      "name" => channel.name,
      "sec_hash" => channel.sec_hash,
      "email" => channel.email,
      "slug" => channel.slug}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, channel_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, channel_path(conn, :create), channel: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Channel, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, channel_path(conn, :create), channel: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    channel = Repo.insert! %Channel{}
    conn = put conn, channel_path(conn, :update, channel), channel: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Channel, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    channel = Repo.insert! %Channel{}
    conn = put conn, channel_path(conn, :update, channel), channel: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    channel = Repo.insert! %Channel{}
    conn = delete conn, channel_path(conn, :delete, channel)
    assert response(conn, 204)
    refute Repo.get(Channel, channel.id)
  end
end
