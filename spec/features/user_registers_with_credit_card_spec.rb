require 'spec_helper'

feature 'User registers with credit card', { js: true, vcr: true } do
  
  background do
    visit register_path
  end
  
  context "with valid personal info input" do
    background do
      fill_in_valid_personal_info
    end
    
    scenario 'valid input and valid credit card' do
      fill_in_credit_card_details("4242424242424242")
      expect(page).to have_content("Welcome to MyFlix")
    end

    scenario "valid input but with invalid card" do
      fill_in_credit_card_details("4000000000000069")
      expect(page).to have_content("Your card has expired.")
    end

    scenario "valid input but declined card" do
      fill_in_credit_card_details("4000000000000002")
      expect(page).to have_content("Your card was declined.")
    end

    scenario "valid input but wrong cvc code on card" do
      fill_in_credit_card_details("4000000000000127")
      expect(page).to have_content("Your card's security code is incorrect.")
    end

    scenario "valid input but card number is incorrect" do
      fill_in_credit_card_details("4242424242424241")
      expect(page).to have_content("Your card number is incorrect.")
    end

    scenario "valid input but no credit card details provided" do
      click_button "Sign Up"
      expect(page).to have_content("This card number looks invalid")
    end
  end
  
  context "with invalid personal info input" do
    
    background do
      fill_in_invalid_personal_info
    end
    
    scenario "invalid input but with valid credit card details" do
      fill_in_credit_card_details("4242424242424242")
      expect(page).to have_content("Your account could not be created.")
    end

    scenario "invalid input and invalid credit card details" do
      fill_in_credit_card_details("4000000000000069")
      expect(page).to have_content("Your account could not be created.")
    end

    scenario "invalid input but card declined" do
      fill_in_credit_card_details("4000000000000002")
      expect(page).to have_content("Your account could not be created.")
    end
  end
  
  def fill_in_valid_personal_info
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Foo Foo"
  end
  
  def fill_in_credit_card_details(credit_card_number)
    fill_in "credit-card-number", with: credit_card_number
    fill_in "cvc", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
    click_button "Sign Up"
  end
  
  def fill_in_invalid_personal_info
    fill_in "Email Address", with: "foo@example.com"
    fill_in "Password", with: "password"
  end
  
end