require 'spec_helper'

feature 'User registers', {js: true, vcr: true} do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_info
    fill_in_valid_card_info
    click_button "Sign Up"
    expect(page).to have_content("Thanks for signing up for my shitty app. The videos are actually just PICTURES LOL. Thanks for the money!")
  end
  

  scenario "with valid user info and invalid card" do
    fill_in_valid_user_info
    fill_in_invalid_card_info
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with valid user info and declined card" do
    fill_in_valid_user_info
    fill_in_declined_card_info
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end
  
  scenario "with invalid user info and valid card" do
    fill_in_invalid_user_info
    fill_in_valid_card_info
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please do it right this time.")
  end
  
  scenario "with invalid user info and invalid card" do
    fill_in_invalid_user_info
    fill_in_invalid_card_info
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with invalid user info and declined card" do
    fill_in_invalid_user_info
    fill_in_declined_card_info
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please do it right this time.")
  end


  def fill_in_valid_user_info
    fill_in "Email Address", with: "bill@example.com"
    fill_in "Password", with: "12345"
    fill_in "Full Name", with: "Bill Bradley"
  end

  def fill_in_valid_card_info
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
  end

  def fill_in_invalid_card_info
    fill_in "Credit Card Number", with: "123"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
  end

  def fill_in_invalid_user_info
    fill_in "Email Address", with: "bill@example.com"
  end

  def fill_in_declined_card_info
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
  end
end

