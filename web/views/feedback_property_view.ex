defmodule Constructeev.FeedbackPropertyView do
  use Constructeev.Web, :view

  def render("index.json", %{feedback_properties: feedback_properties}) do
    %{data: render_many(feedback_properties, Constructeev.FeedbackPropertyView, "feedback_property.json")}
  end

  def render("show.json", %{feedback_property: feedback_property}) do
    %{data: render_one(feedback_property, Constructeev.FeedbackPropertyView, "feedback_property.json")}
  end

  def render("show_property.json", %{feedback_property: feedback_property}) do
    %{id: feedback_property.id,
      feedback_id: feedback_property.feedback_id,
      unread: feedback_property.unread,
      favorite: feedback_property.favorite,
      created_at: feedback_property.inserted_at
    }
  end

  def render("feedback_property.json", %{feedback_property: feedback_property}) do
    %{id: feedback_property.id,
      feedback_id: feedback_property.feedback_id,
      unread: feedback_property.unread,
      favorite: feedback_property.favorite,
      title: feedback_property.feedback.title,
      author: feedback_property.feedback.author,
      content: feedback_property.feedback.content,
      happiness: feedback_property.feedback.happiness,
      channel_id: feedback_property.feedback.channel_id,
      parent_id: feedback_property.feedback.feedback_id,
      feedback_childs: feedback_property.feedback.feedback_childs,
      created_at: feedback_property.feedback.inserted_at
    }
  end

  def render("error.json", %{msg: msg}) do
      %{
      error: true,
      error_msg: msg
      }
  end
end
