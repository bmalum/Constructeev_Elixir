defmodule Constructeev.FeedbackProperty do
  use Constructeev.Web, :model

  schema "feedback_properties" do
    field :unread, :boolean, default: true
    field :favorite, :boolean, default: false
    belongs_to :channel, Constructeev.Channel
    belongs_to :feedback, Constructeev.Feedback

    timestamps
  end

  @required_fields ~w(unread favorite feedback_id channel_id)
  @optional_fields ~w()

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
