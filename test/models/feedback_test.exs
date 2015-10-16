defmodule Constructeev.FeedbackTest do
  use Constructeev.ModelCase

  alias Constructeev.Feedback

  @valid_attrs %{author: "some content", content: "some content", happiness: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feedback.changeset(%Feedback{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feedback.changeset(%Feedback{}, @invalid_attrs)
    refute changeset.valid?
  end
end
