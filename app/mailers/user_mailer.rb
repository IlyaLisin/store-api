class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    @link = build_site_url path: '/profile/email_confirmation',
                           query: { confirmation_token: user.confirmation_token }.to_query

    mail :to => user.email, :subject => "Registration Confirmation"
  end
end
