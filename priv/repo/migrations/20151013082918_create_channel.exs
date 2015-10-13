defmodule Constructeev.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      add :sec_hash, :string
      add :email, :string
      add :slug, :string

      timestamps
    end
    create unique_index(:channels, [:slug])
  end
  
end
