defmodule Constructeev.Channel do
  use Constructeev.Web, :model

  before_insert :generate_sec_hash
  before_insert :has_slug

  schema "channels" do
    field :name, :string
    field :sec_hash, :string
    field :email, :string
    field :slug, :string
    field :description, :string
    field :feedback_counter, :integer, default: 0
    field :likes, :integer, default: 0
    timestamps
    has_many :feedbacks, Constructeev.Feedback
  end

  @required_fields ~w(name email)
  @optional_fields ~w(description slug)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  def has_slug(changeset) do
    {:changes, var_slug} = fetch_field(changeset, :slug)
    if(!var_slug) do
      var_slug = :crypto.strong_rand_bytes(5) |> Base.encode32(case: :lower)
    end
    changeset
    |> Ecto.Changeset.put_change(:slug, var_slug)
  end

  def generate_sec_hash(changeset) do
    sec_hash = :crypto.strong_rand_bytes(5) |> Base.encode32(case: :lower)
    changeset
    |> Ecto.Changeset.put_change(:sec_hash, sec_hash)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
    |> validate_format(:email, ~r/@/)
  end
end
