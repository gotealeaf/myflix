require 'rails_helper'

feature "User signs in" do
  background do
    User.create(email: "cullenjett@gmail.com", password: "password", name: "Cullen Jett")
  end

  scenario "from the navigation sign in" do
    visit root_path
    fill_in "email", with: "cullenjett@gmail.com"
    fill_in "password", with: "password"
    click_button "Sign In"

    expect(page).to have_content "Cullen Jett"
  end 

  scenario "from the sign in page" do
    visit sign_in_path
    find(".sign_in").fill_in "email", with: "cullenjett@gmail.com"
    find(".sign_in").fill_in "password", with: "password"
    find(".sign_in").click_button "Sign In"

    expect(page).to have_content "Cullen Jett"
  end 
end #User signs in