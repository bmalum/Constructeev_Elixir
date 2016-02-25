defmodule Constructeev.Mailer do
  use Mailgun.Client,
      domain: Application.get_env(:constructeev, :mailgun_domain),
      key: Application.get_env(:constructeev, :mailgun_key)

      def send_welcome_text_email(email_address) do
  			 send_email to: email_address,
             from: "no-reply@constructeev.com",
             subject: "Welcome!",
             text: "Welcome to HelloPhoenix!"
end
end