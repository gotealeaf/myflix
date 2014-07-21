require "spec_helper"

feature "user login" do
  scenario "logging in with a valid user email and password" do
    jamie = Fabricate(:user)
    sign_in(jamie)
    expect(page).to have_content(jamie.fullname)
  end
end