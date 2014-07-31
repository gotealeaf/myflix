require "spec_helper"

feature "User sings in" do
  scenario "with valid email and password" do
    user = Fabricate(:user)
    visit signin_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    page.should have_content user.full_name
  end
end
