defmodule Constructeev.Repo.Migrations.AddLikesToChannelTable do
  use Ecto.Migration

  def change do
  	alter table(:channels) do
      add :likes, :integer, default: 0
    end
  end
end
