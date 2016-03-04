defmodule Constructeev.Mailer do
	alias Constructeev.Channel
	use Mailgun.Client,
	domain: Application.get_env(:constructeev, :mailgun_domain),
	key: Application.get_env(:constructeev, :mailgun_key)#,
	#mode: :test,
	#test_file_path: "/tmp/mailgun.json"

	@from "no-reply@bmalum.com"

	def send_welcome_email(channel) do
		send_email to: channel.email,
		from: @from,
		subject: "Welcome!",
		text: welcome_text,
		html: Phoenix.View.render_to_string(Constructeev.EmailView, "welcome.html", channel)
	end

	def welcome_text do
		"""
		String
		"""
	end
end