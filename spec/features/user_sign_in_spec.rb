require 'rails_helper'

feature "Signing in" do
  scenario 'with registered user' do
    user_signs_in(user)
    expect(page).to have_content("Welcome #{ user.username }")
  end

  scenario 'with unregistered user' do
    user_signs_in
    expect(page).to have_content('Incorrect email or password. Please try again.')
  end

  scenario 'with deactivated user' do
    user = Fabricate(:user, status: 'inactive')
    user_signs_in(user)
    expect(page).not_to have_content("Welcome #{ user.username }")
    expect(page).to have_content('Your account has been suspended.')
  end
end
