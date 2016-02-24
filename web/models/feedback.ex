defmodule Constructeev.Feedback do
  use Constructeev.Web, :model

  schema "feedbacks" do
    field :title, :string
    field :author, :string
    field :content, :string
    field :happiness, :integer
    field :feedback_childs, :integer, default: 0
    belongs_to :channel, Constructeev.Channel
    belongs_to :feedback, Constructeev.Feedback
    has_many :feedbacks, Constructeev.Feedback
    has_one :feedback_properties, Constructeev.FeedbackProperty
    timestamps
  end

  @required_fields ~w(title author content happiness)
  @optional_fields ~w(feedback_id)

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
