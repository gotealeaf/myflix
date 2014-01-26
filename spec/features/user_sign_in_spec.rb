require 'spec_helper'

feature "user_sign_in" do
  scenario "user enters email and password" do
    # alice = Fabricate(:user)
    # visit sign_in_path  
    # fill_in "Email Address", with: alice.email
    # fill_in "Password", with: alice.password
    # click_button "Sign in"
    # page.should have_content alice.full_name

    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content alice.full_name




  end
end