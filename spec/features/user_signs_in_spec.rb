require 'spec_helper'

feature "User signs in" do
  scenario "with existing account" do
    joe = Fabricate(:user)
    feature_sign_in_user(joe)
    page.should have_content "Welcome, #{joe.name}"
  end
end
