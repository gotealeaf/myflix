require 'spec_helper'

feature 'User signs in' do
  background do
    User.create(email: "john@example.com", password: "example123", full_name: "John Doe")
  end

  scenario "with existing email address" do
    visit sign_in_path
    fill_in "email", with: "john@example.com"
    fill_in "Password", with: "example123"
    click_button "Sign in"
    page.should have_content "John Doe"
  end
end