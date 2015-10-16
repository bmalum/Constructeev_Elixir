defmodule Constructeev.SessionView do
  use Constructeev.Web, :view

  def render("session.json", %{channel: channel}) do
   %{
      valid: true,
      id: channel.id,
      name: channel.name,
      sec_hash: channel.sec_hash,
      email: channel.email,
      slug: channel.slug}
  end

  def render("show.json", %{channel: channel}) do
      %{
      valid: true,
      id: channel.id,
      name: channel.name,
      sec_hash: channel.sec_hash,
      email: channel.email,
      slug: channel.slug}
  end  

   def render("error.json", %{error_msg: msg}) do
      %{
      valid: false,
      error: msg,
      }
  end

end
