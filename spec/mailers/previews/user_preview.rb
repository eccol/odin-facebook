# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def welcome_email
    user = User.first
    UserMailer.welcome_email(user)
  end

  def friend_request_email
    user_a = User.first
    user_b = User.last
    UserMailer.with(sender: user_a, recipient: user_b).friend_request_email
  end
end
