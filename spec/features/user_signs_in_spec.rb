require 'spec_helper'


feature 'user signs in' do
  background do
    User.create(email: 'rick.heller@yahoo.com', password: 'password', full_name: 'Rick Heller')
  end

  scenario 'with existing username' do
    visit sign_in_path
    fill_in "Email Address", with: 'rick.heller@yahoo.com'
    fill_in "Password", with: 'password'
    click_button "Sign In"
    page.should have_content "Welcome, " + "Rick Heller"
  end

scenario 'with INVALID username' do
    visit sign_in_path
    fill_in "Email Address", with: 'joe.cool@yahoo.com'
    fill_in "Password", with: 'nopassword'
    click_button "Sign In"
    page.should have_content "Sign In"
  end


end
