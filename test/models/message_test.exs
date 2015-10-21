defmodule Constructeev.MessageTest do
  use Constructeev.ModelCase

  alias Constructeev.Message

  @valid_attrs %{content: "some content", parent_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
