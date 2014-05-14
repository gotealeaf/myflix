require 'spec_helper'

feature "User logs in" do
  scenario "with correct credentials" do
    alice = Fabricate(:user)
    sign_in_user(alice)
    expect(page).to have_content "Welcome, #{alice.full_name}!"
  end

  scenario "with incorrect credentials" do
    alice = Fabricate(:user)
    visit login_path
    fill_in 'Email Address', with: alice.email + 'bad_email'
    fill_in 'Password', with: alice.password + 'bad_password'
    click_button 'Sign in'
    expect(page).to have_content %{Something was wrong with the email or 
                                  password you entered. Please try again.}
  end
end