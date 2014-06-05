require 'spec_helper'

feature 'User registers with credit card', { js: true, vcr: true } do
  
  background do
    visit register_path
  end
  
  scenario 'valid input and valid credit card' do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    fill_in "credit-card-number", with: "4242424242424242"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Welcome to MyFlix")
  end
  
  scenario "valid input but with invalid card" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    fill_in "credit-card-number", with: "4000000000000069"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your card has expired.")
  end
  
  scenario "valid input but declined card" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    fill_in "credit-card-number", with: "4000000000000002"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end
  
  scenario "valid input but wrong cvc code on card" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    fill_in "credit-card-number", with: "4000000000000127"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your card's security code is incorrect.")
  end
  
  scenario "valid input but card number is incorrect" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    fill_in "credit-card-number", with: "4242424242424241"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your card number is incorrect.")
  end
  
  scenario "valid input but no credit card details provided" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
    click_button "Sign Up"
    expect(page).to have_content("This card number looks invalid")
  end
  
  scenario "invalid input but with valid credit card details" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "credit-card-number", with: "4242424242424242"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your account could not be created.")
  end
  
  scenario "invalid input and invalid credit card details" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "credit-card-number", with: "4000000000000069"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your account could not be created.")
  end
  
  scenario "invalid input but card declined" do
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "credit-card-number", with: "4000000000000002"
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
    expect(page).to have_content("Your account could not be created.")
  end
  
end