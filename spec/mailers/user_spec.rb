require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  it 'sends a welcome email on user signup' do
    user = User.create!(email: "a@a.a", password: "123456")
    expect { UserMailer.welcome_email(user).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email when friend request received' do
    user_a = User.create!(email: "a@a.a", password: "123456")
    user_b = User.create!(email: "b@b.b", password: "123456")
    FriendRequest.create!(sender: user_a, recipient: user_b)
    expect { UserMailer.with(sender: user_a, recipient: user_b).friend_request_email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
