require "spec_helper"

feature "user login" do
  scenario "logging in with a valid user email and password" do
    jamie = Fabricate(:user)
    sign_in_user(jamie)
  end
end