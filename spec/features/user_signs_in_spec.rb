require 'spec_helper'

feature "user signs in" do
  scenario "with correct email and password" do
    jane = User.create(full_name: "Jane Doe", password: "password", email: "jane@example.com")
    visit login_path
    fill_in "Email Address", with: "jane@example.com"
    fill_in "Password", with: "password"
    click_button 'Sign in'
    page.should have_content "Jane Doe"
  end
end