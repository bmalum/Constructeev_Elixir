defmodule Constructeev.Message do
  use Constructeev.Web, :model

  schema "messages" do
    field :parent_id, :integer
    field :content, :string
    belongs_to :feedback, Constructeev.Feedback

    timestamps
  end

  @required_fields ~w(parent_id content)
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
