defmodule Constructeev.Channel do
  use Constructeev.Web, :model

  before_insert :generate_sec_hash

  schema "channels" do
    field :name, :string
    field :sec_hash, :string
    field :email, :string
    field :slug, :string
    field :description, :string
    field :feedback_counter, :integer
    field :likes, :integer
    timestamps
    has_many :feedbacks, Constructeev.Feedback
  end

  @required_fields ~w(name email slug)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def generate_sec_hash(changeset) do
    sec_hash = :crypto.strong_rand_bytes(5) |> Base.encode32(case: :lower)
    changeset
    |> Ecto.Changeset.put_change(:sec_hash, sec_hash)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end
end
