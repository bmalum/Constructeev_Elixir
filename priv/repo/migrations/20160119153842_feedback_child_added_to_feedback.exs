defmodule Constructeev.Repo.Migrations.FeedbackChildAddedToFeedback do
  use Ecto.Migration

  def change do
  	alter table(:feedbacks) do
      add :feedback_childs, :integer, default: 0
    end
  end
end
