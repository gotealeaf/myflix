require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
  	amanda = Fabricate(:user)
  	visit sign_in_path
  	fill_in "Email Address", with: amanda.email
  	fill_in "Password", with: amanda.password
  	click_button "Sign in"
  	page.should have_content amanda.full_name
  end
end