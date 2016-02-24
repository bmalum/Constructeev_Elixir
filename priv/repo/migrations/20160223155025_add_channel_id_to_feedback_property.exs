defmodule Constructeev.Repo.Migrations.AddChannelIdToFeedbackProperty do
  use Ecto.Migration

  def change do
  	alter table(:feedback_properties) do
      add :channel_id, :integer
    end
  end
end
