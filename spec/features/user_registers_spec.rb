require 'spec_helper'

feature 'User registers', { js: true, vcr: true } do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_info
    fill_in_card "4242424242424242"
    click_button "Sign Up"
    expect(page).to have_content("You have succesfully created your account.")
  end

  scenario "with valid user info and invalid card" do
    fill_in_valid_user_info
    fill_in_card "123"
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with valid user info and declined card" do
    fill_in_valid_user_info
    fill_in_card "4000000000000002"
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end

  scenario "with invalid user info and valid card" do
    fill_in_invalid_user_info
    fill_in_card "4242424242424242"
    click_button "Sign Up"
    expect(page).to have_content("User couldn't be created. Please check the errors bellow.")
  end

  scenario "with invalid user info and invalid card" do
    fill_in_invalid_user_info
    fill_in_card "123"
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with invalid user info and declined card" do
    fill_in_invalid_user_info
    fill_in_card "4000000000000002"
    click_button "Sign Up"
    expect(page).to have_content("User couldn't be created. Please check the following errors.")
  end 

  def fill_in_valid_user_info 
    fill_in "Email Address", with: "paq12345@paq.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    fill_in "Full name", with: "Paquito el Último Lazzax"
  end

  def fill_in_invalid_user_info 
    fill_in "Email Address", with: "paq12345@paq.com"
  end 

  def fill_in_card card_number
    fill_in "Credit Card Number", with: card_number
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2016", from: "date_year"
  end
end