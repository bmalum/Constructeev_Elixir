defmodule Constructeev.Repo.Migrations.CreateChannelProperty do
  use Ecto.Migration

  def change do
    create table(:channel_properties) do
      add :hidden_feedback, :boolean, default: false
      add :channel_id, references(:channels)

      timestamps
    end
    create index(:channel_properties, [:channel_id])

  end
end
