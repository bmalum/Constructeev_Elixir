defmodule Constructeev.FeedbackPropertyTest do
  use Constructeev.ModelCase

  alias Constructeev.FeedbackProperty

  @valid_attrs %{favorite: true, unread: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FeedbackProperty.changeset(%FeedbackProperty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FeedbackProperty.changeset(%FeedbackProperty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
