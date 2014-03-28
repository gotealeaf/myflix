require "spec_helper"

feature "user login" do
  scenario "with valid email and password" do
    desmond = Fabricate(:user)
    sign_in(desmond)
    expect(page).to have_content desmond.fullname

    clear_email
  end
end
