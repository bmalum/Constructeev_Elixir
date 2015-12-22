defmodule Constructeev.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      add :sec_hash, :string
      add :email, :string
      add :slug, :string, unique: true
      add :description, :text
      add :feedback_counter, :integer, default: 0
      timestamps
    end
    create unique_index(:channels, [:slug])
  end
  
end
