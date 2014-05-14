require 'spec_helper'

feature 'User registers', { js: true, vcr: true } do
  background { visit register_path }

  scenario 'with valid personal info and valid card' do
    alice = Fabricate.build(:user)
    
    fill_in_user_info(alice)
    fill_in_valid_credit_card_info
    click_register
    confirm_successful_registration(alice)
    sign_in_user(alice)
    confirm_user_registered(alice)
  end

  scenario 'with valid personal info and invalid card' do
    alice = Fabricate.build(:user)
    fill_in_user_info(alice)
    click_register
    confirm_rejection_for_invalid_card
    sign_in_user(alice)
    confirm_user_not_registered
  end

  scenario 'with valid personal info and card declined' do
    alice = Fabricate.build(:user)
    
    fill_in_user_info(alice)
    fill_in_declined_credit_card_info
    click_register
    confirm_rejection_for_declined_card
    sign_in_user(alice)
    confirm_user_not_registered
  end

  scenario 'with invalid personal info and valid card' do
    alice = Fabricate.build(:bad_user)
    
    fill_in_user_info(alice)
    fill_in_valid_credit_card_info
    click_register
    confirm_rejection_for_invalid_info
    sign_in_user(alice)
    confirm_user_not_registered
  end

  scenario 'with invalid personal info and invalid card' do
    alice = Fabricate.build(:bad_user)
    
    fill_in_user_info(alice)
    fill_in_invalid_credit_card_info
    click_register
    confirm_rejection_for_invalid_card
    sign_in_user(alice)
    confirm_user_not_registered
  end

  scenario 'with invalid personal info and card declined' do
    alice = Fabricate.build(:bad_user)
    
    fill_in_user_info(alice)
    fill_in_declined_credit_card_info
    click_register
    confirm_rejection_for_invalid_info
    sign_in_user(alice)
    confirm_user_not_registered
  end
end

def fill_in_user_info(user)
  fill_in "Full Name", with: user.full_name
  fill_in "Password", with: user.password
  fill_in "Email Address", with: user.email
end

def fill_in_valid_credit_card_info
  fill_in "Credit Card Number", with: "4242424242424242"
  fill_in "Security Code", with: "123"
  select "6 - June", from: "date_month"
  select "2017", from: "date_year"
end

def fill_in_invalid_credit_card_info
  fill_in "Credit Card Number", with: "123"
  fill_in "Security Code", with: "123"
  select "6 - June", from: "date_month"
  select "2017", from: "date_year"
end

def fill_in_declined_credit_card_info
  fill_in "Credit Card Number", with: "4000000000000002"
  fill_in "Security Code", with: "123"
  select "6 - June", from: "date_month"
  select "2017", from: "date_year"
end

def click_register
  click_button "Register"
end

def confirm_successful_registration(user)
  expect(page).to have_content("You registered! Welcome, #{user.full_name}!")
end

def confirm_rejection_for_invalid_card 
  expect(page).to have_content("This card number looks invalid")
end

def confirm_rejection_for_declined_card 
  expect(page).to have_content("Your card was declined.")
end

def confirm_rejection_for_invalid_info
  expect(page).to have_content("Please correct the following errors:")
  expect(page).to have_content("can't be blank")
end