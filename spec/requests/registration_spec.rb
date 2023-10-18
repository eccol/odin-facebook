require 'rails_helper'

RSpec.describe 'Registration', type: :feature do

  before do
    visit new_user_registration_path
  end

  context 'with all fields validly filled' do
    it 'is valid' do
      fill_in 'user_email', with: 'user@website.com'
      fill_in 'user_password', with: 'ABC123'
      fill_in 'user_password_confirmation', with: 'ABC123'
      fill_in 'user_profile_attributes_name', with: "Joe Robot"
      fill_in 'user_profile_attributes_birthday', with: Date.current
      fill_in 'user_profile_attributes_city', with: 'Newtown'
      click_button 'Sign up'
      expect(User.last.email).to eq 'user@website.com'
    end
  end

  context 'when user already exists' do
    it 'is not valid' do
      User.create!(email: 'user@website.com', password: '123456')
      fill_in 'user_email', with: 'user@website.com'
      fill_in 'user_password', with: 'ABC123'
      fill_in 'user_password_confirmation', with: 'ABC123'
      fill_in 'user_profile_attributes_name', with: "Joe Robot"
      click_button 'Sign up'
      expect(page).to have_content 'error'
    end
  end

  context 'when not all fields are filled' do
    it 'is not valid without a name' do
      fill_in 'user_email', with: 'user@website.com'
      fill_in 'user_password', with: 'ABC123'
      fill_in 'user_password_confirmation', with: 'ABC123'
      click_button 'Sign up'
      expect(page).to have_content 'error'
    end

    it 'is valid without optional fields' do
      fill_in 'user_email', with: 'user@website.com'
      fill_in 'user_password', with: 'ABC123'
      fill_in 'user_password_confirmation', with: 'ABC123'
      fill_in 'user_profile_attributes_name', with: "Joe Robot"
      click_button 'Sign up'
      expect(User.last.email).to eq 'user@website.com'
    end
  end
end