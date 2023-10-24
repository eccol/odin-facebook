require 'rails_helper'

RSpec.describe Notification, type: :feature do
  context "when user sends a friend request" do
    it "creates a notification" do
      user_a = User.create!(email: "a@a.a", password: "123456", profile_attributes: {name: "Sender"})
      user_b = User.create!(email: "b@b.b", password: "123456", profile_attributes: {name: "Recipient"})
      login_as(user_a)
      visit users_path
      within('form', text: "Recipient") do
        click_button('Send Friend Request')
      end
      expect(Notification.last.user).to eq(user_b)
    end
  end
end
