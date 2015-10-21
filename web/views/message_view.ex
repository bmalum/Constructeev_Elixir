defmodule Constructeev.MessageView do
  use Constructeev.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, Constructeev.MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, Constructeev.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      feedback_id: message.feedback_id,
      parent_id: message.parent_id,
      content: message.content}
  end
end
