require "spec_helper"

feature "user login" do
  scenario "with valid email and password" do
    desmond = Fabricate(:user)
    sign_in(desmond)
    expect(page).to have_content desmond.fullname

    clear_email
  end

  scenario "with deactive users" do
    desmond = Fabricate(:user, active: false)
    sign_in(desmond)
    expect(page).not_to have_content desmond.fullname
    expect(page).to have_content "Your account has been suspend, please contact customer service!"
  end
end
