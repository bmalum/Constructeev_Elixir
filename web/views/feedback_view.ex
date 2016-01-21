defmodule Constructeev.FeedbackView do
  use Constructeev.Web, :view

  def render("index.json", %{feedbacks: feedbacks}) do
    %{data: render_many(feedbacks, Constructeev.FeedbackView, "feedback.json")}
  end

  def render("show.json", %{feedback: feedback}) do
    %{data: render_one(feedback, Constructeev.FeedbackView, "feedback.json")}
  end

  def render("feedback.json", %{feedback: feedback}) do
    %{id: feedback.id,
      title: feedback.title,
      author: feedback.author,
      content: feedback.content,
      happiness: feedback.happiness,
      channel_id: feedback.channel_id,
      parent_id: feedback.feedback_id,
      feedback_childs: feedback.feedback_childs,
      created_at: feedback.inserted_at
    }
  end

  def render("error.json", %{error_msg: msg}) do
      %{
      error: msg
      }
  end
end
