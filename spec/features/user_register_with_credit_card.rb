require 'rails_helper'

feature 'User registers with credit card', { js: true, vcr: true, driver: :selenium } do

  background { visit register_path }

  scenario 'with valid credit card details' do
    enter_registration_details('4242424242424242')
    click_button 'Sign Up'
    expect(page).to have_content('Welcome, John')
  end

  scenario 'with invalid credit card details' do
    enter_registration_details('4000000000000002')
    click_button 'Sign Up'
    expect(page).to have_content('Your card was declined')
  end

  def enter_registration_details(credit_card_nr)
    fill_in 'Username', with: 'Unicorn'
    fill_in 'Full Name', with: 'John Unicorn'
    fill_in 'Email Address', with: 'john@unicorn.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    fill_in 'card_number', with: credit_card_nr
    fill_in 'card_cvc', with: '123'
    select('2016', from: 'card-expiry-year')
  end
end
