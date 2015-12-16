defmodule Constructeev.ChannelControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.Channel
  @valid_attrs %{email: "some content", name: "some content", slug: "some content", description: "some content", feedback_counter: 10}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, channel_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, channel_path(conn, :create), channel: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
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
