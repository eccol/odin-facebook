require 'rails_helper'

RSpec.describe "Posts", type: :feature do
  context "when viewing posts" do
    let(:user_a) { User.create!(email: 'x@x.x', password: '123456')}
    let(:user_b) { User.create!(email: 'y@y.y', password: '123456')}
    let(:friend_request) { FriendRequest.create(sender: user_a, recipient: user_b) }

    before do
      user_a.build_profile(name: "A").save
      user_b.build_profile(name: "B").save
      user_b.posts.new(content: "Don't look at this.").save
      login_as(user_a)
    end

    it "shows posts from friends" do
      friend_request.accept
      visit root_path
      expect(page).to have_content("Don't look at this.")
    end

    it "does not show posts from non-friends" do
      visit root_path
      expect(page).not_to have_content("Don't look at this.")
    end
  end

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
