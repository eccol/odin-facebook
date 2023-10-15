require 'rails_helper'

RSpec.describe "Users", type: :feature do
  describe "GET /index" do
    xit "displays a list of users" do
      pending 'Rewrite this test after creating profile information'
      User.create!(email: "a@a.a", password: "123456")
      visit users_path
      expect(page).to have_text('a@a.a')
    end
  end
end