require 'rails_helper'

feature "Signing in" do
  scenario 'with registered user' do
    sign_in(user)
    expect(page).to have_content("Welcome #{ user.username }")
  end

  scenario 'with unregistered user' do
    sign_in
    click_button 'Sign in'
    expect(page).to have_content('Incorrect email or password. Please try again.')
  end
end
