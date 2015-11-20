defmodule Constructeev.FeedbackControllerTest do
  use Constructeev.ConnCase

  alias Constructeev.Feedback

  @valid_attrs %{author: "some content", content: "some content", happiness: 42, title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end


end
