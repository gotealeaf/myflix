require 'spec_helper'

feature "User sings in" do

  scenario "with valid email and password" do
    user = Fabricate(:user)
    signin(user)
    expect(page).to have_content user.full_name
  end

end
