class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Fakebook!")
  end

  def friend_request_email
    @sender = params[:sender]
    @recipient = params[:recipient]
    mail(to: @recipient.email, subject: "You received a friend request!")
  end
end
