defmodule Constructeev.ChannelPropertyTest do
  use Constructeev.ModelCase

  alias Constructeev.ChannelProperty

  @valid_attrs %{hidden_feedback: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChannelProperty.changeset(%ChannelProperty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChannelProperty.changeset(%ChannelProperty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
