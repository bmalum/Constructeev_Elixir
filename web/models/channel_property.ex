defmodule Constructeev.ChannelProperty do
  use Constructeev.Web, :model

  schema "channel_properties" do
    field :hidden_feedback, :boolean, default: false
    belongs_to :channel, Constructeev.Channel

    timestamps
  end

  @required_fields ~w(channel_id)
  @optional_fields ~w(hidden_feedback)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
