require 'spec_helper'

feature "signing in" do
  scenario "with correct email and password" do
    jane = Fabricate(:user)
    sign_in_user(jane)
    page.should have_text(jane.full_name)
  end
  
  scenario "a deactivated user cannot sign in" do
    foo = Fabricate(:user, active: false)
    sign_in_user(foo)
    page.should have_content("Your account is no longer active. Please contact us.")
    page.should_not have_content(foo.full_name)
  end
end