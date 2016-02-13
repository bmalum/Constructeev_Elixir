defmodule Constructeev.ChannelView do
  use Constructeev.Web, :view

  def render("index.json", %{channels: channels}) do
    %{data: render_many(channels, Constructeev.ChannelView, "channel.json")}
  end

  def render("show.json", %{channel: channel}) do
    %{data: render_one(channel, Constructeev.ChannelView, "channel.json")}
  end

  def render("channel.json", %{channel: channel}) do
    %{id: channel.id,
      name: channel.name,
      sec_hash: channel.sec_hash,
      email: channel.email,
      slug: channel.slug,
      description: channel.description,
      feedback_counter: channel.feedback_counter,
      likes: channel.likes,
      updated_at: channel.updated_at,
      channel_hash: :crypto.hash(:md5, channel.name) |> Base.encode16 |> String.downcase
      }
  end

  def render("error.json", %{error_msg: msg}) do
      %{
      error: msg,
      }
  end

end
