defmodule Constructeev.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :title, :string
      add :author, :string
      add :content, :text
      add :happiness, :integer
      add :channel_id, references(:channels)
      add :feedback_id, references(:feedbacks)

      timestamps
    end
    create index(:feedbacks, [:channel_id])
  end
end
