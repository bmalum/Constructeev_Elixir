defmodule Constructeev.Feedback do
  use Constructeev.Web, :model

  schema "feedbacks" do
    field :title, :string
    field :author, :string
    field :content, :string
    field :happiness, :integer
    belongs_to :channel, Constructeev.Channel

    timestamps
  end

  @required_fields ~w(title author content happiness)
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
