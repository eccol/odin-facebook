require 'rails_helper'

RSpec.describe "Users", type: :feature do
  describe "GET /index" do
    it "displays a list of users" do
      user = User.create!(email: "a@a.a", password: "123456").build_profile(name: "Superman")
      user.save
      visit users_path
      expect(page).to have_text('Superman')
    end

    it "allows sending friend requests" do
      sending_user = User.create!(email: "send@send.send", password: "123456")
      sending_user.build_profile(name: "Joker").save
      receiving_user = User.create!(email: "get@get.get", password: "123456")
      receiving_user.build_profile(name: "Batman").save
      login_as(sending_user)
      visit users_path
      find('form', text: "Batman").find_button("Send Friend Request").click
      expect(sending_user.sent_friend_requests.first.recipient).to eq(receiving_user)
    end
  end
end