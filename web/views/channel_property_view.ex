defmodule Constructeev.ChannelPropertyView do
  use Constructeev.Web, :view

  def render("index.json", %{channel_properties: channel_properties}) do
    %{data: render_many(channel_properties, Constructeev.ChannelPropertyView, "channel_property.json")}
  end

  def render("show.json", %{channel_property: channel_property}) do
    %{data: render_one(channel_property, Constructeev.ChannelPropertyView, "channel_property.json")}
  end

  def render("channel_property.json", %{channel_property: channel_property}) do
    %{id: channel_property.id,
      channel_id: channel_property.channel_id,
      hidden_feedback: channel_property.hidden_feedback}
  end
end
