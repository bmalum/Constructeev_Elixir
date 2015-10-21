defmodule Constructeev.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :parent_id, :integer
      add :content, :string
      add :feedback_id, references(:feedbacks)

      timestamps
    end
    create index(:messages, [:feedback_id])

  end
end
