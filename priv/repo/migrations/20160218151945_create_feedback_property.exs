defmodule Constructeev.Repo.Migrations.CreateFeedbackProperty do
  use Ecto.Migration

  def change do
    create table(:feedback_properties) do
      add :unread, :boolean, default: false
      add :favorite, :boolean, default: false
      add :feedback_id, references(:feedbacks)

      timestamps
    end
    create index(:feedback_properties, [:feedback_id])

  end
end
