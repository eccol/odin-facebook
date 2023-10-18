require 'rails_helper'

RSpec.describe "Posts", type: :feature do
  context "when making a post" do
    it "appears" do
      Capybara.current_driver = :selenium_chrome_headless
      user = User.create!(email: "a@a.a", password: "123456")
      user.build_profile(name: "Superman")
      user.save
      login_as(user)
      visit root_path
      fill_in 'post[content]', with: 'abcxyz'
      click_button 'Post'
      expect(page).to have_content('abcxyz')
    end

    it "appears on the same page" do
      Capybara.current_driver = :selenium_chrome_headless
      user = User.create!(email: "a@a.a", password: "123456")
      user.build_profile(name: "Superman")
      user.save
      login_as(user)
      visit root_path
      fill_in 'post[content]', with: 'abcxyz'
      click_button 'Post'
      expect(page).to have_current_path(root_path)
    end
  end
end
