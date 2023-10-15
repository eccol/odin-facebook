require 'rails_helper'

RSpec.describe "Users", type: :feature do
  describe "GET /index" do
    it "displays a list of users" do
      user = User.create!(email: "a@a.a", password: "123456").build_profile(name: "Superman")
      user.save
      visit users_path
      expect(page).to have_text('Superman')
    end
  end
end